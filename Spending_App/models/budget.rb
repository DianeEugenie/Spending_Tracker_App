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
    #create a budget left property?
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

#Get the total amount spent per transaction belonging to a specific budget with tag_id
  def spent()

    total = 0
    for transaction in transactions()
      total += transaction.amount
    end
    return total
  end



  # #Maybe give budget the power to save transaction and decrease budget this way?
  # def save_transaction(transaction)
  #   price = transaction.amount()
  #   Transaction.new(
  #     'tag_id' => @tag_id,
  #     'merchant_id' => transaction.merchant_id(),
  #     'tr_date' => transaction.tr_date(),
  #     'amount' => price).save()
  #   @budget -= price
  #   update()
  #   alert()
  # end


  end






end
