require_relative('../models/tag.rb')
require_relative('../models/merchant.rb')

#INDEX
get '/tags' do
  @tags = Tag.all()
  erb(:'tags/index')
end

#NEW
get '/tags/new' do
  erb(:'tags/new')
end

#CREATE

post '/tags' do
  tag = Tag.new(params)
  tag.save()
  redirect '/tags'
end

#SHOW

get '/tags/:id' do
  id = params[:id].to_i
  @tag = Tag.find(id)
  @merchants = Merchant.all()
  erb(:'tags/show')
end
