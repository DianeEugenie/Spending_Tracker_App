require_relative('../models/transaction.rb')
require_relative('../models/tag.rb')
require_relative('../models/merchant.rb')

#INDEX
get '/transactions' do
  @transactions = Transaction.all()
  erb(:'transactions/index')
end



#
# #
# #
# @id = transaction['id'].to_i if transaction['id']
# @tag_id = transaction['tag_id'].to_i
# @merchant_id = transaction['merchant_id'].to_i
# @tr_date = transaction['tr_date']
# @amount = transaction['amount'].to_f
