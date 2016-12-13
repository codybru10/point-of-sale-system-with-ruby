require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('/lib/**/*.rb')
require('./lib/purchase')
require('./lib/product')
require('pg')

get('/') do
  
  erb(:index)
end
