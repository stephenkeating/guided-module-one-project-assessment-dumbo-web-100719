class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :deliverer_id
      t.integer :customer_seed_cost  # subtracted from customer
      t.integer :deliverer_seed_payout # (cost + 2) paid to deliverer
    end 
  end
end
