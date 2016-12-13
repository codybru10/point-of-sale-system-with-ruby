class Product < ActiveRecord::Base
  belongs_to :purchase, touch: true, dependent: :destroy
  validates(:name, :price, :presence => true)
end
