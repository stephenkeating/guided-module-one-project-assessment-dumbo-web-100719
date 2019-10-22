class Character < ActiveRecord::Base
  has_many :orders
        
  has_many :orders_as_customer, class_name: 'Order', foreign_key: "customer_id" #this will go through all the orders and give us the order instances where the instance of character is the customer
  has_many :deliverers, through: :orders_as_customer, source: :deliverer #this will go through the order list and get the person who delivered the order

  has_many :orders_as_deliverer, class_name: 'Order', foreign_key: "deliverer_id"
  has_many :customers, through: :orders_as_deliverer, source: :customer

  # def main menu
    # menu.choice name: "View Previous Orders", value: self.view_deliveries -> name of a method
    # menu.choice name: "Create Order", value: Order.create_order(self) # the self here is the character instance that called that new order to be created
 # end 

 # def view_deliveries
    self.orders_as_deliverer.each do |order|
      order.name
    end 
  # end

 #below is in order class
  # def self.create_order(customer_instance) # the customer instance is drawn from the order that we created uner character menu


  # end 

 

end
