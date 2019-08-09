require_relative('../db/sql_runner')
require('pry-byebug')

class Merchant

  attr_reader :id
  attr_accessor :name

  def initialize(merchant)
    @id = merchant['id'].to_i if merchant['id']
    @name = merchant['name']
  end


end
