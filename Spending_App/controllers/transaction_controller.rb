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

#DELETE
post '/transactions/:id/delete' do
  id = params[:id].to_i()
  transaction = Transaction.find(id)
  transaction.delete()
  redirect '/transactions'
end

#EDIT
get '/transactions/:id/edit' do
  @tags = Tag.all()
  @merchants = Merchant.all()
  id = params[:id].to_i()
  @transaction = Transaction.find(id)
  erb(:'transactions/edit')
end


#UPDATE
post '/transactions/:id' do
  transaction = Transaction.new(params)
  transaction.update()
  redirect '/transactions'
end
