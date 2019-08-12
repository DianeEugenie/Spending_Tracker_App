require_relative('../db/sql_runner')
require_relative('../models/tag.rb')
require_relative('../models/transaction.rb')
require_relative('../models/merchant.rb')
require_relative('../models/budget.rb')

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
    # adjust_budget()
  end

  def self.delete_all()
    sql = 'DELETE FROM transactions;'
    SqlRunner.run(sql)
  end


  def self.all()
    sql = 'SELECT * FROM transactions;'
    transaction_data = SqlRunner.run(sql)
    transactions = transaction_data.map { |transaction| Transaction.new(transaction) }
    return transactions
  end

  def update()
    sql = 'UPDATE transactions
    SET (tag_id, merchant_id, tr_date, amount)
    = ($1, $2, $3, $4)
    WHERE id = $5;'
    values = [@tag_id, @merchant_id, @tr_date, @amount, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM transactions
    WHERE id = $1;'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = 'SELECT * FROM transactions
    WHERE id = $1;'
    values = [id]
    transaction_hash = SqlRunner.run(sql, values).first()
    transaction = Transaction.new(transaction_hash)
    return transaction
  end

  def self.find_tag(tag_id)
    sql = 'SELECT * FROM transactions
    WHERE tag_id = $1;'
    values = [tag_id]
    transactions_hash = SqlRunner.run(sql, values)
    transactions = transactions_hash.map{ |transaction| Transaction.new(transaction)}
    return transactions
  end

  def merchant()
    sql = 'SELECT * FROM merchants
    WHERE id = $1;'
    values = [@merchant_id]
    merchant = SqlRunner.run(sql, values).first()
    return Merchant.new(merchant)
  end

  def tag()
    sql = 'SELECT * FROM tags
    WHERE id = $1;'
    values = [@tag_id]
    tag = SqlRunner.run(sql, values).first()
    return Tag.new(tag)
  end

#Total of all transactions
  def self.sum()
    transactions = self.all()
    amounts = transactions.map{ |transaction| transaction.amount}
    sum = amounts.sum()
    return sum
  end




  #Sort by time
  def self.all_by_date()
    sql = 'SELECT * FROM transactions
    ORDER BY tr_date DESC;'
    transaction_data = SqlRunner.run(sql)
    sorted_transactions = transaction_data.map { |transaction| Transaction.new(transaction) }
    return sorted_transactions
  end

  #Filter by tag
  def self.all_filtered(tag_id)
    sql = 'SELECT * FROM transactions
    WHERE tag_id = $1
    ORDER by tr_date DESC;'
    values = [tag_id]
    filtered_data = SqlRunner.run(sql, values)
    filtered_transactions = filtered_data.map {
    |transaction| Transaction.new(transaction)}
    return filtered_transactions
  end

  #Filter by unique tags
  def self.filtered()
    sql = 'SELECT DISTINCT ON (tag_id) transactions.* FROM transactions;'
    tr_data = SqlRunner.run(sql)
    tags = tr_data.map { |transaction| Transaction.new(transaction)}
    return tags
  end

  #Select budget of a tag of the transaction?
  def get_budget()
    sql = 'SELECT b.* FROM budgets b
    INNER JOIN transactions t
    ON t.tag_id = b.tag_id
    WHERE t.tag_id = $1
    LIMIT 1;'
    values = [@tag_id]
    budget = SqlRunner.run(sql, values).first()
    return Budget.new(budget)
  end





end
