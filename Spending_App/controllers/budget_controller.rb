require_relative('../models/budget.rb')
require_relative('../models/tag.rb')

#INDEX
get '/budgets' do
  @budgets = Budget.all()
  @tags = Tag.all()
  erb(:'budgets/index')
end

#SHOW

get '/budgets/:id' do
  id = params['id'].to_i()
  @budget = Budget.find(id)
  erb(:'/budgets/show')
end
