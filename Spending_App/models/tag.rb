require_relative('../db/sql_runner')
require('pry-byebug')

class Tag

  attr_reader :id
  attr_accessor :type

  def initialize(tag)
    @id = tag['id'].to_i if tag['id']
    @type = tag['type']
  end

  def save()
    sql = 'INSERT INTO tags (type)
    VALUES ($1)
    RETURNING id;'
    values = [@type]
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
  end

  def update()
    sql = 'UPDATE tags
    SET type = $1
    WHERE id = $2;'
    values = [@type, @id]
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


end
