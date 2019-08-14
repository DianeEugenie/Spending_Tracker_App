require('sinatra')
require('sinatra/contrib/all')
also_reload('../models/*' )
require_relative('./controllers/tag_controller.rb')
require_relative('./controllers/merchant_controller.rb')
require_relative('./controllers/transaction_controller.rb')
require_relative('./controllers/budget_controller.rb')

require('pry-byebug')


get '/' do
  @budgets = Budget.all()
  @transactions = Transaction.all_by_date_limit()
  @merchants = Merchant.all()
  @tags = Tag.all()
  erb(:index)
end
