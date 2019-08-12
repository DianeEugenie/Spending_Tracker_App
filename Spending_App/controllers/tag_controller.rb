require_relative('../models/tag.rb')
require_relative('../models/merchant.rb')
require_relative('../models/budget.rb')
require_relative('../models/transaction.rb')

#INDEX
get '/tags' do
  @tags = Tag.all()
  @budgets = Budget.all()
  @merchants = Merchant.all()
  @transactions = Transaction.all()
  erb(:'tags/index')
end

#NEW
get '/tags/new' do
  @budgets = Budget.all()
  erb(:'tags/new')
end

#CREATE
post '/tags' do
  @budgets = Budget.all()
  tag = Tag.new(params)
  tag.save()
  redirect '/tags'
end

#SHOW
get '/tags/:id' do
  id = params[:id].to_i()
  @tag = Tag.find(id)
  @merchants = Merchant.all()
  @budgets = Budget.all()
  erb(:'tags/show')
end

#DELETE
post '/tags/:id/delete' do
  id = params[:id].to_i()
  tag = Tag.find(id)
  tag.delete()
  redirect '/tags'
end

#EDIT
get '/tags/:id/edit' do
  @budgets = Budget.all()
  id = params[:id].to_i
  @tag = Tag.find(id)
  erb(:'tags/edit')
end

#UPDATE
post '/tags/:id' do
  tag = Tag.new(params)
  tag.update()
  redirect '/tags'
end
