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
  erb(:'/budgets/new')
end

#CREATE
post '/budgets' do
  budget = Budget.new(params)
  budget.save()
  redirect '/budgets'
end

#SHOW

get '/budgets/:id' do
  id = params['id'].to_i()
  @budget = Budget.find(id)
  erb(:'/budgets/show')
end
