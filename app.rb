require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('/lib/**/*.rb')
require('./lib/purchase')
require('./lib/product')
require('pg')
require('pry')

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
  Product.new({:name => name, :price => price})
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
  if @product.save()
    erb(:product)
  else
    erb(:error)
  end
end

delete('/product/:id') do
  @product = Product.find(params.fetch('id').to_i)
  @product.destroy()
  @products = Product.all
  erb(:products)
end

get('/purchases')do
  @products = Product.all
  erb(:purchases)
end

get('/purchase/:id') do
  @purchase = Purchase.find(params.fetch('id'))
  @products = @purchase.products()
  erb(:purchase)
end

post('/purchase') do
  @purchase = Purchase.create({:total => 0, :purchase_date => params.fetch('date')})
  @checked = params.fetch('product')
  @checked.each do |each|
    product = Product.find(each.to_i)
    product.update({:purchase_id => @purchase.id(), :purchased? => true})
  end
  @purchase.total_cost()
  @purchase.save()
  @products = @purchase.products()
  erb(:purchase)
end

get('/purchases/all') do
  @purchases = Purchase.all()
  erb(:all_purchases)
end

post('/purchase_filter') do
  start_date = params.fetch('start_date')
  end_date = params.fetch('end_date')
  @purchases = Purchase.between(start_date, end_date)
  erb(:all_purchases)
end

get('/clear')do
  Product.all().each do |product|
    product.destroy()
  end
  Purchase.all().each do |purchase|
    purchase.destroy()
  end
  erb(:index)
end
