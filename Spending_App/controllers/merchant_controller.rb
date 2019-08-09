require_relative('../models/merchant.rb')

#INDEX
get '/merchants' do
  @merchants = Merchant.all()
  erb(:'merchants/index')
end

#NEW
get '/merchants/new' do
  erb(:'merchants/new')
end

#CREATE
post '/merchants' do
  merchant = Merchant.new(params)
  merchant.save()
  redirect '/merchants'
end

#SHOW
get '/merchants/:id' do
  id = params[:id].to_i()
  @merchant = Merchant.find(id)
  erb(:'merchants/show')
end
