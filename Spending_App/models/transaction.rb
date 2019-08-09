require_relative('../db/sql_runner')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
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








end
