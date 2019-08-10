require_relative('../db/sql_runner.rb')

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

end
