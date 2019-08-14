require_relative('../db/sql_runner')
require_relative('../models/transaction.rb')
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
    return merchants
  end

  def update()
    sql = 'UPDATE merchants
    SET name = $1
    WHERE id = $2;'
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql ='DELETE FROM merchants
    WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = 'SELECT * FROM merchants
    WHERE id = $1'
    values = [id]
    merchant_hash = SqlRunner.run(sql, values).first()
    merchant = Merchant.new(merchant_hash)
    return merchant
  end

#Get transactions for a specific merchant
  def transactions()
    sql = 'SELECT t.* FROM transactions t
    INNER JOIN merchants m
    ON t.merchant_id = m.id
    WHERE t.merchant_id = $1;'
    values = [@id]
    transactions = SqlRunner.run(sql, values)
    return transactions.map { |transaction| Transaction.new(transaction)}
  end

#Get most popular merchant
  def self.most_popular_merchant()
    sql = "SELECT merchant_id,
    COUNT(*) AS count
    FROM transactions
    GROUP BY merchant_id
    ORDER BY count
    DESC LIMIT 1;"
    popular_merchant = SqlRunner.run(sql).first['merchant_id'].to_i
    Merchant.find(popular_merchant)
  end



end
