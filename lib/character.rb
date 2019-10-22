class Character < ActiveRecord::Base
  has_many :orders
        
  has_many :orders_as_customer, class_name: 'Order', foreign_key: "customer_id"
  has_many :deliverers, through: :orders_as_customer, source: :deliverer

  has_many :orders_as_deliverer, class_name: 'Order', foreign_key: "deliverer_id"
  has_many :customers, through: :orders_as_deliverer, source: :customer
end

