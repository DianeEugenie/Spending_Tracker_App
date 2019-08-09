require_relative('../models/tag.rb')
require_relative('../models/merchant.rb')
require_relative('../models/transaction.rb')
require('pry-byebug')

Transaction.delete_all()
Tag.delete_all()
Merchant.delete_all()

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

merchant3 = Merchant.new(
  {
    'name' => 'TESCO'
  }
)


merchant1.save()
merchant2.save()
merchant3.save()

transaction1 = Transaction.new(
  {
    'tag_id' => tag1.id,
    'merchant_id' => merchant1.id,
    'amount' => 10.50,
    'tr_date' => '09/08'
  }
)

transaction2 = Transaction.new(
  {
    'tag_id' => tag2.id,
    'merchant_id' => merchant3.id,
    'amount' => 18.99,
    'tr_date' => '09/08'
  }
)

transaction1.save()
transaction2.save()

# transaction2.merchant_id = merchant2.id
# transaction2.amount = 18.20
# transaction2.update()

# merchant1.name = 'PureGym'
# merchant1.update()
# merchant2.delete()


# tag2.type = 'Sports'
# tag2.update()
# tag1.delete()

binding.pry

nil
