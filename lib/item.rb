class Item < ActiveRecord::Base
    # has_many :order_items
    has_many :orders, through: :order_items

    def self.name_and_price
        self.all.map do |item| 
          "#{item.name}  ".white + "  #{item.price}".blue 
        end
      end
end 