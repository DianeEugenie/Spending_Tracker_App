# require_relative('../db/sql_runner')
require('pry-byebug')

class Tag

  attr_reader :id
  attr_accessor :type

  def initialize(tag)
    @id = tag['id'].to_i if tag['id']
    @type = tag['type']
  end


end
