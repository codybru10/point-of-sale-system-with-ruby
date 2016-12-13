class Purchase < ActiveRecord::Base
  has_many(:products)
  after_touch(:total_cost)
  before_destroy(:subtract_cost)

  private
    define_method(:total_cost) do
      purchase_price = 0
      purchases_items = self.products()
      purchases_items.each do |each|
        purchase_price += each.price()
      end
      self.total = purchase_price
    end

    define_method(:subtract_cost) do
      subtract_amount = 0
      purchases_items = self.products()
      purchases_items.each do |each|
        subtract_amount += each.price()
      end
      self.total -= subtract_amount
    end
end
