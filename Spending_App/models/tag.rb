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


end
