require_relative('../db/sql_runner.rb')

class Budget

  attr_reader :id
  attr_accessor :budget

  def initialize(budget)
    @id = budget['id'].to_i if budget['id']
    @budget = budget['budget'].to_i
  end


end
