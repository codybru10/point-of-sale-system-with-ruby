class Product < ActiveRecord::Base
  belongs_to :purchase, touch: true, dependent: :destroy
end
