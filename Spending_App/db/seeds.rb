require_relative('../models/tag.rb')
require('pry-byebug')

Tag.delete_all()

tag1 = Tag.new(
  {
    'type' => 'Entertainment'
  }
)

tag2 = Tag.new(
  {
    'type' => 'Groceries'
  }
)

tag1.save()
tag2.save()

tag2.type = 'Sports'
tag2.update()

binding.pry

nil
