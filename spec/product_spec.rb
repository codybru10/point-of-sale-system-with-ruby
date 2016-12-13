require('spec_helper')

describe(Product) do
  describe('#purchase') do
    it('adds multiple products to a purchase') do
      purchase1 = Purchase.create({:total => 0, :purchase_date => '12-11-2016'})
      product1 = purchase1.products.create({:name => 'Old Chair', :price => 12.10})
      product2 = purchase1.products.create({:name => 'Old Chair', :price => 12.10})
      expect(purchase1.products()).to(eq([product1, product2]))
    end
  end
  describe('#total_cost') do
    it('adds multiple products to a purchase') do
      purchase1 = Purchase.create({:total => 0, :purchase_date => '12-11-2016'})
      purchase2 = Purchase.create({:total => 0, :purchase_date => '12-12-2016'})
      product1 = purchase1.products.create({:name => 'Old Chair', :price => 12.10})
      product2 = purchase1.products.create({:name => 'Old Chair', :price => 24.50})
      product3 = purchase2.products.create({:name => 'Old Chair', :price => 5.00})
      expect(purchase1.total()).to(eq(36.6))
      expect(purchase2.total()).to(eq(5.00))
    end
  end

  describe('#subtract_cost') do
    it('subtracts cost of deleted products') do
      purchase1 = Purchase.create({:total => 0, :purchase_date => '12-11-2016'})
      purchase2 = Purchase.create({:total => 0, :purchase_date => '12-12-2016'})
      product1 = purchase1.products.create({:name => 'Old Chair', :price => 12.10})
      product2 = purchase1.products.create({:name => 'Old Chair', :price => 24.50})
      product3 = purchase2.products.create({:name => 'Old Chair', :price => 5.00})
      product3.destroy()
      expect(purchase1.total()).to(eq(36.6))
      expect(purchase2.total()).to(eq(0))
    end
  end

  describe('#subtract_cost') do
    it('subtracts cost of deleted products') do
      purchase1 = Purchase.create({:total => 0, :purchase_date => '12-11-2016'})
      product1 = Product.create({:name => 'Old Chair', :price => 12.10})
      product1.update({:purchase_id => purcha.id()})
      expect(purchase1.total()).to(eq(12.1))
    end
  end


end
