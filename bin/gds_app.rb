# require "tty-prompt"

# prompt = TTY::Prompt.new

class GdsApp

  @@chosen_character
  @@item_selected_for_checkout
  @@all_characters_without_chosen_character
  @@open_order
  @@item_selected_name_and_price

#use a clear after each method

  def self.main_menu
    #put clear command here to clean up the CLI
    system "clear"
    puts "Hello and welcome to Ghibli Delivery Serviceß!".green
    prompt.keypress("Enter", key: [:enter])
    choose_character_page
  end

  def self.choose_character_page #figure out how to make seeds always have 3 digits && make columns color coded
    system "clear"
    char_list = Character.all_stats
    character_selected = prompt.select("Choose your character!\n\nCharacter  | " + "Seeds ".blue + "| " + "Orders to Deliver".green + "\n--------------------------------------\n", char_list, per_page: 10)
    character_name = character_selected.slice(0...8)
    @@chosen_character = Character.find_by_name(character_name)
    @@all_characters_without_chosen_character = Character.where.not(id: @@chosen_character.id)
    # character_page(Character.find_by_name(character_name))
    character_page
  end

  def self.character_page #need to display seeds and deliveries
    system "clear"
    puts "Hi" + " #{@@chosen_character.name.rstrip}!!".yellow + "\nYou have " + "#{@@chosen_character.seeds} seeds".blue + " & " + "#{@@chosen_character.orders_as_deliverer.count} order(s)".green + " to deliver!"
    selection = prompt.select("What would you like to do?") do |menu|
      menu.choice name: 'New Order',  value: 1
      menu.choice name: 'Deliver an Order', value: 2
      menu.choice name: 'View History',  value: 3
      menu.choice name: 'Go back to Charater Menu',  value: 4
    end
    if selection == 1
      #binding.pry
     @@open_order = Order.create(customer_id: @@chosen_character.id, deliverer_id: @@all_characters_without_chosen_character.sample.id, customer_seed_cost: 0, deliverer_seed_payout: 0, status: "open")
      new_order_page
    elsif selection == 2
      # deliver_order_page
    elsif selection == 3
      # view_history_page
    elsif selection == 4
      choose_character_page
    end
  end


  def self.new_order_page #show the seeds but make sure they have enough 
    #add 'cancel order' button if we can get multiselect to work
    system "clear"
  
    # items_list = Item.name_and_price
    # @@item_selected_for_checkout = prompt.select("Hi " + "#{@@chosen_character.name.rstrip}".yellow + ". Press enter to add item and proceed to checkout.\n" + "Items:       Prices:", items_list, per_page: 10)
    # #OrderItem.create(order_id: )

    items_list = Item.name_and_price
    @@item_selected_name_and_price = prompt.select("Hi " + "#{@@chosen_character.name.rstrip}".yellow + ". Press enter to add item and proceed to checkout.\n" + "Items:       Prices:", items_list, per_page: 10)
    selected_item_name =  @@item_selected_name_and_price.slice(10...18)
    @@item_selected_for_checkout = Item.find_by_name(selected_item_name)
    OrderItem.create(order_id: @@open_order.id, item_id: @@item_selected_for_checkout.id)
    checkout_page
    
  end

  def self.checkout_page
    system "clear"
    puts "Hi " + "#{@@chosen_character.name.rstrip}".yellow + ", here is your order!\n" + "\nCart" + "\n-----------------------------\n"+ "Item:  Price:     " + "\n-----------------------------\n" + "#{@@item_selected_name_and_price}"
  
    selection = prompt.select("\nWhat would you like to do?") do |menu|
      menu.choice name: 'Place Order',  value: 1
      menu.choice name: 'Pick a Different Item', value: 2
      menu.choice name: 'Cancel Order',  value: 3
    end
    if selection == 1
      loading_pending_order_page
    elsif selection == 2
      new_order_page
    elsif selection == 3
      character_page
    end
  end

  def self.loading_pending_order_page
    #put an image here and bring back to main menu; say ___is delivering your order; change order status to "ready to deliver"
    prompt.keypress("Enter", key: [:enter])
    choose_character_page
  end

  def self.prompt
        @@prompt ||= TTY::Prompt.new
      end
    

  

end

