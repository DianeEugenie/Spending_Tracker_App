require_relative('../models/tag.rb')
require('pry-byebug')

tag1 = Tag.new(
  {
  'type' => 'Entertainment'
  }
)

tag2 = Tag.new({
  'type' => 'Groceries'
  })
