require('sinatra')
require('sinatra/contrib/all')
also_reload('../models/*' )
require_relative('./controllers/tag_controller.rb')
require_relative('./controllers/merchant_controller.rb')
require_relative('./controllers/transaction_controller.rb')

require('pry-byebug')


get '/' do
  erb(:index)
end

# binding.pry
#
# nil
