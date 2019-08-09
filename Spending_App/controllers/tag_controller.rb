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

#DELETE
post '/tags/:id/delete' do
  id = params[:id].to_i()
  tag = Tag.find(id)
  tag.delete()
  redirect '/tags'
end

#EDIT
get '/tags/:id/edit' do
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
