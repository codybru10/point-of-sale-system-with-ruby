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

get('/products') do
  @products = Product.all()
  erb(:products)
end

post('/products') do
  name = params.fetch('name')
  price = params.fetch('price').to_f
  Product.create({:name => name, :price => price})
  @products = Product.all()
  erb(:products)
end

get('/product/:id') do
  @product = Product.find(params.fetch('id').to_i)
  erb(:product)
end

patch('/product/:id') do
  @product = Product.find(params.fetch('id').to_i)
  name = params.fetch('name')
  price = params.fetch('price').to_f
  @product.update({:name => name, :price => price})
  erb(:product)
end

delete('/product/:id') do
  @product = Product.find(params.fetch('id').to_i)
  @product.destroy()
  @products = Product.all
  erb(:products)
end
