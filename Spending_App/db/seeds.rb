require_relative('../models/tag.rb')
require_relative('../models/merchant.rb')
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

merchant1 = Merchant.new(
  {
    'name' => 'Cineworld'
  }
)

merchant2 = Merchant.new(
  {
    'name' => 'Bannatynes'
  }
)



# tag2.type = 'Sports'
# tag2.update()
# tag1.delete()

binding.pry

nil
