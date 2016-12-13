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
end
