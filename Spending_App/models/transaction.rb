require_relative('../db/sql_runner')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
require_relative('../models/merchant.rb')
require('pry-byebug')

class Transaction

  attr_reader :id
  attr_accessor :amount, :tr_date, :tag_id, :merchant_id

  def initialize(transaction)
    @id = transaction['id'].to_i if transaction['id']
    @tag_id = transaction['tag_id'].to_i
    @merchant_id = transaction['merchant_id'].to_i
    @tr_date = transaction['tr_date']
    @amount = transaction['amount'].to_f
  end

  def save()
    sql = 'INSERT INTO transactions
    (tag_id, merchant_id, tr_date, amount)
    VALUES ($1, $2, $3, $4)
    RETURNING id;'
    values = [@tag_id, @merchant_id, @tr_date, @amount]
    result = SqlRunner.run(sql, values)
    id = result.first['id']
    @id = id.to_i()
  end








end
