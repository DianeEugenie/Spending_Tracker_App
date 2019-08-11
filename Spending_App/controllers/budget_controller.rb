require_relative('../models/budget.rb')
require_relative('../models/tag.rb')

#INDEX
get '/budgets' do
  @budgets = Budget.all()
  @tags = Tag.all()
  erb(:'budgets/index')
end

#NEW
get '/budgets/new' do
  @tags = Tag.all()
  erb(:'/budgets/new')
end

#CREATE
post '/budgets' do
  @tags = Tag.all()
  budget = Budget.new(params)
  budget.save()
  redirect '/budgets'
end

#SHOW
get '/budgets/:id' do
  @tags = Tag.all()
  id = params['id'].to_i()
  @budget = Budget.find(id)
  erb(:'/budgets/show')
end

#DELETE
post '/budgets/:id/delete' do
  id = params['id'].to_i()
  budget = Budget.find(id)
  budget.delete()
  redirect '/budgets'
end

#EDIT
get '/budgets/:id/edit' do
  @tags = Tag.all()
  id = params['id'].to_i()
  @budget = Budget.find(id)
  erb(:'budgets/edit')
end

#UPDATE
post '/budgets/:id' do
  budget = Budget.new(params)
  budget.update()
  redirect '/budgets'
end
