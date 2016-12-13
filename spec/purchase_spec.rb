require('spec_helper')

describe(Purchase) do
  describe('#products') do
    it('sets an empty array at first') do
      purchase1 = Purchase.create({:total => 0, :purchase_date => '12-11-2016'})
      product1 = purchase1.products.create({:name => 'Old Chair', :price => 12.10})
      expect(purchase1.products()).to(eq([product1]))
      expect(product1.purchase()).to(eq(purchase1))
    end
  end

  describe('.between') do
    it('retrieves purchases in date range') do
      purchase1 = Purchase.create({:total => 0, :purchase_date => '25-12-2016'})
      purchase2 = Purchase.create({:total => 0, :purchase_date => '1-11-2016'})
      purchase3 = Purchase.create({:total => 0, :purchase_date => '26-12-2016'})
      expect(Purchase.between('2016-12-01', '2016-12-31')).to(eq([purchase1, purchase3]))
    end
  end

end
