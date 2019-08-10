require_relative('../db/sql_runner.rb')
require_relative('../models/tag.rb')

class Budget

  attr_reader :id
  attr_accessor :budget

  def initialize(budget)
    @id = budget['id'].to_i if budget['id']
    @budget = budget['budget'].to_i
  end

  def save()
    sql = 'INSERT INTO budgets (budget)
    VALUES ($1)
    RETURNING id;'
    values = [@budget]
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
    SET budget = $1
    WHERE id = $2;'
    values = [@budget, @id]
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


  # def decrease(transaction)
  #   budget_left = @budget
  #   tr_amount = transaction.amount()
  #   return unless @budget > 0
  #   @budget -= tr_amount
  #   update()
  # end
  #

  def tags()
    sql = 'SELECT * FROM tags
    WHERE budget_id = $1;'
    values = [@id]
    tags_data = SqlRunner.run(sql, values)
    tags = tags_data.map { |tag| Tag.new(tag) }
    return tags
  end






    # film = screening.film
    # price = film.price
    # return unless screening.empty_seats > 0
    #
    #
    #   def decrease(budget)
    #     if budget.tag_id == @tag_id && budget.budget() > 0
    #       budget_left = budget.budget()
    #       tr_amount = @amount
    #       new_budget = (budget.budget() - tr_amount)
    #       budget.update()
    #     end
    #   end
  #
  # def alert()
  #   if (@budget > 0 && @budget <= 30)
  #     return "Only £#{@budget} left!"
  #   elsif (@budget == 0)
  #     return 'Budget reached!'
  #   elsif (@budget < 0)
  #     return 'Over budget!'
  #   else
  #     return "£#{@budget} left!"
  #   end
  # end






end
