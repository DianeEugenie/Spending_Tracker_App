require_relative('../db/sql_runner')
require_relative('../models/merchant.rb')
require('pry-byebug')

class Tag

  attr_reader :id
  attr_accessor :type, :budget_id

  def initialize(tag)
    @id = tag['id'].to_i if tag['id']
    @type = tag['type']
    @budget_id = tag['budget_id'].to_i
  end

  def save()
    sql = 'INSERT INTO tags (type, budget_id)
    VALUES ($1, $2)
    RETURNING id;'
    values = [@type, @budget_id]
    result = SqlRunner.run(sql, values)
    id = result.first['id']
    @id = id.to_i()
  end

  def self.delete_all()
    sql = 'DELETE FROM tags;'
    SqlRunner.run(sql)
  end

  def self.all()
    sql = 'SELECT * FROM tags;'
    tag_data = SqlRunner.run(sql)
    tags = tag_data.map { |tag| Tag.new(tag)}
    return tags
  end

  def update()
    sql = 'UPDATE tags
    SET (type, budget_id) = ($1, $2)
    WHERE id = $3;'
    values = [@type, @budget_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = 'DELETE FROM tags
    WHERE id = $1;'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = 'SELECT * FROM tags
    WHERE id = $1;'
    values = [id]
    tag_hash = SqlRunner.run(sql, values).first()
    tag = Tag.new(tag_hash)
    return tag
  end

#Get merchants for a specific tag
  def merchants()
    sql = 'SELECT m.* FROM merchants m
    INNER JOIN transactions t
    ON t.merchant_id = m.id
    WHERE t.tag_id = $1;'
    values = [@id]
    merchants = SqlRunner.run(sql, values)
    return merchants.map { |merchant| Merchant.new(merchant)}
  end



end
