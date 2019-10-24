class Character < ActiveRecord::Base
  has_many :orders
        
  has_many :orders_as_customer, class_name: 'Order', foreign_key: "customer_id" #this will go through all the orders and give us the order instances where the instance of character is the customer
  has_many :deliverers, through: :orders_as_customer, source: :deliverer #this will go through the order list and get the person who delivered the order

  has_many :orders_as_deliverer, class_name: 'Order', foreign_key: "deliverer_id"
  has_many :customers, through: :orders_as_deliverer, source: :customer

  def self.all_stats
    self.all.map do |character| 
      order_count = character.orders_as_deliverer.count
      "#{character.name}" + " |   ".white + "#{character.seeds}".blue + "  |    " + "#{order_count}".green
    end
  end

  def my_orders_as_deliverer_string  #make a hash where the keys are "customer.name | seed payout" and the value is the Order instance
    arr_of_order_name_and_price = self.orders_as_deliverer.map do |order|
      "#{order.customer.name}  |  #{order.deliverer_seed_payout}"
    end
  end

  def my_orders_as_deliverer_hash # returns a hash with a string of customer name and order payout as key, and order instance as value
    self.my_orders_as_deliverer_string.zip(self.orders_as_deliverer).to_h
  end


  # def self.all_stats_hash
  #   stats_hash = Hash[self.all_stats.collect { |stat_string| [stat_string, character.]}]
  # end

  # def view_character

  # end 

  
  # def main menu
    # menu.choice name: "View Previous Orders", value: self.view_deliveries -> name of a method
    # menu.choice name: "Create Order", value: Order.create_order(self) # the self here is the character instance that called that new order to be created
 # end 

 # def view_deliveries
    # self.orders_as_deliverer.each do |order|
    #   order.name
    # end 
  # end

 #below is in order class
  # def self.create_order(customer_instance) # the customer instance is drawn from the order that we created uner character menu


  # end 

 

end

