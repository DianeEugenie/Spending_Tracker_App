require_relative('../models/tag.rb')
require_relative('../models/merchant.rb')

#INDEX
get '/tags' do
  @tags = Tag.all()
  erb(:'tags/index')
end

#SHOW

get '/tags/:id' do
  id = params[:id].to_i
  @tag = Tag.find(id)
  erb(:'tags/show')
end



#NEW
get '/tags/new' do
  erb(:'tags/new')
end
