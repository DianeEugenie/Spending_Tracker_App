require_relative('../db/sql_runner.rb')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')

class Budget

  attr_reader :id
  attr_accessor :budget, :tag_id

  def initialize(budget)
    @id = budget['id'].to_i if budget['id']
    @budget = budget['budget'].to_f
    @tag_id = budget['tag_id'].to_i
  end

  def save()
    sql = 'INSERT INTO budgets (budget, tag_id)
    VALUES ($1, $2)
    RETURNING id;'
    values = [@budget, @tag_id]
    result = SqlRunner.run(sql, values)
    id = result.first['id']
    @id = id.to_i()
  end

  def self.delete_all()
    sql = 'DELETE FROM budgets;'
    SqlRunner.run(sql)
  end

  def self.all()
    sql = 'SELECT * FROM budgets;'
    budget_data = SqlRunner.run(sql)
    budgets = budget_data.map {|budget| Budget.new(budget)}
    return budgets
  end

  def update()
    sql = 'UPDATE budgets
    SET (budget, tag_id) = ($1, $2)
    WHERE id = $3;'
    values = [@budget, @tag_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM budgets
    WHERE id = $1;'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = 'SELECT * FROM budgets
    WHERE id = $1;'
    values = [id]
    budget_hash = SqlRunner.run(sql, values).first()
    budget = Budget.new(budget_hash)
    return budget
  end


  def tag()
    sql = 'SELECT * FROM tags
    WHERE id = $1;'
    values = [@tag_id]
    tag = SqlRunner.run(sql, values).first
    return Tag.new(tag)
  end

  def transactions()
    sql = 'SELECT * FROM transactions
    WHERE tag_id = $1'
    values = [@tag_id]
    transaction_hash = SqlRunner.run(sql, values)
    transactions = transaction_hash.map { |transaction| Transaction.new(transaction)}
    return transactions
  end


  def sum()
    transactions = transactions()
    amount = transactions.map{ |transaction| transaction.amount }
    sum = amount.sum()
    @budget -= sum
    update()
  end

  def decrease_budget()
    sql = 'SELECT * FROM transactions
    WHERE tag_id = $1'
    values = [@tag_id]
    transaction_hash = SqlRunner.run(sql, values)
    transactions = transaction_hash.map { |transaction| Transaction.new(transaction)}
    amount = transactions.map{ |transaction| transaction.amount }
    sum = amount.sum()
    @budget -= sum
    update()
  end










  # def self.sum()
  #   transactions = Budget.transactions()
  #   amount = transactions.map{ |transaction| transaction.amount }
  #   sum = amount.sum()
  #   return sum
  # end





  # def decrease_budget(transaction)
  #   transactions = Transaction.all()
  #   for transaction in transactions
  #     amount = transactions.reduce{ |transaction| transaction.amount() }
  #     @budget -= amount
  #   end
  # end
  #



  #
  #   if (@tag_id == transaction.tag_id())
  #     budget_left = @budget
  #     tr_amount = transaction.amount()
  #     return unless @budget > 0
  #     @budget -= tr_amount
  #     update()
  #   end
  # end






  def alert()
    if (@budget > 0 && @budget <= 30)
      return "Only £#{@budget} left!"
    elsif (@budget == 0)
      return 'Budget reached!'
    elsif (@budget < 0)
      return 'Over budget!'
    else
      return "£#{@budget} left!"
    end
  end






end
