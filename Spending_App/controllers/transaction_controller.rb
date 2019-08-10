require_relative('../models/transaction.rb')
require_relative('../models/tag.rb')
require_relative('../models/merchant.rb')

#INDEX
get '/transactions' do
  @transactions = Transaction.all()
  erb(:'transactions/index')
end

#NEW
get '/transactions/new' do
  @tags = Tag.all()
  @merchants = Merchant.all()
  erb(:'transactions/new')
end


#CREATE
post '/transactions' do
  transaction = Transaction.new(params)
  transaction.save()
  redirect '/transactions'
end



#SHOW
get '/transactions/:id' do
  id = params[:id].to_i()
  @transaction = Transaction.find(id)
  erb(:'transactions/show')
end



#
# #
# #
# @id = transaction['id'].to_i if transaction['id']
# @tag_id = transaction['tag_id'].to_i
# @merchant_id = transaction['merchant_id'].to_i
# @tr_date = transaction['tr_date']
# @amount = transaction['amount'].to_f
