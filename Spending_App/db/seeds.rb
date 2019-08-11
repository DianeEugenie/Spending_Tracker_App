require_relative('../models/tag.rb')
require_relative('../models/merchant.rb')
require_relative('../models/transaction.rb')
require_relative('../models/budget.rb')
require('pry-byebug')

Transaction.delete_all()
Budget.delete_all()
Merchant.delete_all()
Tag.delete_all()


tag1 = Tag.new(
  {
    'type' => 'Entertainment',
  }
)

tag2 = Tag.new(
  {
    'type' => 'Groceries',
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

merchant4 = Merchant.new(
  {
    'name' => 'VUE'
  }
)

merchant1.save()
merchant2.save()
merchant3.save()
merchant4.save()

budget1 = Budget.new(
  {
    'budget' => 500,
    'tag_id' => tag1.id
  }
)

budget2 = Budget.new(
  {
    'budget' => 300,
    'tag_id' => tag2.id
  }
)

budget1.save()
budget2.save()
#
# budget2.delete()

# budget1.budget = 200
# budget1.update()




transaction1 = Transaction.new(
  {
    'tag_id' => tag1.id,
    'merchant_id' => merchant1.id,
    'amount' => 50,
    'tr_date' => '2019-06-30'
  }
)

transaction2 = Transaction.new(
  {
    'tag_id' => tag2.id,
    'merchant_id' => merchant3.id,
    'amount' => 100,
    'tr_date' => '2019-07-15'
  }
)

transaction3 = Transaction.new(
  {
    'tag_id' => tag1.id,
    'merchant_id' => merchant4.id,
    'amount' => 50,
    'tr_date' => '2019-08-10'
  }
)

transaction1.save()
transaction2.save()
transaction3.save()
# transaction1.delete()

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
