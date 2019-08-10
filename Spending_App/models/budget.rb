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

  

end
