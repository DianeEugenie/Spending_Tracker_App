require_relative('../db/sql_runner')
require('pry-byebug')

class Merchant

  attr_reader :id
  attr_accessor :name

  def initialize(merchant)
    @id = merchant['id'].to_i if merchant['id']
    @name = merchant['name']
  end

  def save()
    sql = 'INSERT INTO merchants (name)
    VALUES ($1)
    RETURNING id;'
    values = [@name]
    result = SqlRunner.run(sql, values)
    id = result.first['id']
    @id = id.to_i()
  end

  def self.delete_all()
    sql = 'DELETE FROM merchants;'
    SqlRunner.run(sql)
  end

  def self.all()
    sql = 'SELECT * FROM merchants;'
    merchant_data = SqlRunner.run(sql)
    merchants = merchant_data.map{ |merchant| Merchant.new(merchant)}
  end


end
