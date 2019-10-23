class Order < ActiveRecord::Base
  
  belongs_to :customer, class_name: 'Character', foreign_key: 'customer_id'
  belongs_to :deliverer, class_name: 'Character', foreign_key: 'deliverer_id'
   
  def self.get_deliverer
    self.all.map do |order|
      order.deliverer_id
    end
  end
end 