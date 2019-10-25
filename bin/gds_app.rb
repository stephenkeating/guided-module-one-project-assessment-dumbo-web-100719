# require "tty-prompt"

# prompt = TTY::Prompt.new

class GdsApp

  @@chosen_character
  @@item_selected_for_checkout
  @@all_characters_without_chosen_character
  @@open_order
  @@item_selected_name_and_price
  # @@current_delivery
  @@delivered_order

#use a clear after each method

  def self.main_menu
    #put clear command here to clean up the CLI
    system "clear"
    # ascii = ASCII_Image.new("http://www.levihackwith.com/wp-content/uploads/2011/10/github-logo.png")
    # ascii.build(8) can't get 'ascii-image' gem to work 
    pid = fork{ exec 'afplay', "./gds_music/main.mp3" } 
    
    Catpix::print_image "./gds_pics/ghibli_splash.png",
    :limit_x => 1.0,
    :limit_y => 0,
    :center_x => true,
    :center_y => true,
    :bg => "white",
    :bg_fill => false
    
    puts "\nHello and welcome to Ghibli Delivery Service!".green
    sleep(3)
    puts "
    \nWarring armies are devastating the Forest! 
    \nHeal the Forest by working together with your friends to gather magical seeds.
    \nPlace and deliver orders to each other create more seeds.
    \nLet's play!"
    
    # prompt.keypress("\nPress [Enter] to Start", key: [:enter])
    # choose_character_page

    selection = prompt.select("\n") do |menu|
      menu.choice name: 'Play Ghibli Delivery Service',  value: 1
      menu.choice name: 'Reset the Game and Play', value: 2
    end
    if selection == 1
      choose_character_page
    elsif selection == 2
      Order.destroy_all
      Character.all.update(seeds: 20)
      choose_character_page
    end
  end

  def self.choose_character_page #figure out how to make seeds always have 3 digits && make columns color coded
    system "clear"
    char_list = Character.all_stats
    character_selected = prompt.select("Choose your character!\n\nCharacter  | " + "Seeds ".blue + "| " + "Orders to Deliver".green + "\n--------------------------------------\n", char_list, per_page: 11)
    # character_page(Character.find_by_name(character_name))
    if character_selected == "Main Menu".magenta
      main_menu
    else
      character_name = character_selected.slice(0...8)
      @@chosen_character = Character.find_by_name(character_name)
      @@all_characters_without_chosen_character = Character.where.not(id: @@chosen_character.id)
      character_page
    end
  end

  def self.character_page #need to display seeds and deliveries
    system "clear"
    local_chosen_character = @@chosen_character
    #updated_chosen_char_count = local_chosen_character.orders_as_deliverer.where(status: "Ready to Deliver").count
    local_chosen_character.display_art
    puts "Hi" + " #{@@chosen_character.name.rstrip}!!\n".yellow + "\nYou have " + "#{@@chosen_character.seeds} seeds".blue + " & " + "#{@@chosen_character.orders_as_deliverer.count} order(s)".green + " to deliver!"
    selection = prompt.select("\nWhat would you like to do?") do |menu|
      menu.choice name: 'New Order',  value: 1
      menu.choice name: 'Deliver an Order', value: 2
      menu.choice name: 'Go back to Charater Menu',  value: 3
    end
    if selection == 1
      #binding.pry
     @@open_order = Order.create(customer_id: @@chosen_character.id, deliverer_id: @@all_characters_without_chosen_character.sample.id, customer_seed_cost: 0, deliverer_seed_payout: 0, status: "open")
      new_order_page
    elsif selection == 2
      deliver_order_page
    elsif selection == 3
      choose_character_page
    end
  end


  def self.new_order_page #show the seeds but make sure they have enough 
    #add 'cancel order' button if we can get multiselect to work
    system "clear"
    current_order = @@open_order
    # items_list = Item.name_and_price
    # @@item_selected_for_checkout = prompt.select("Hi " + "#{@@chosen_character.name.rstrip}".yellow + ". Press enter to add item and proceed to checkout.\n" + "Items:       Prices:", items_list, per_page: 10)
    # #OrderItem.create(order_id: )

    items_list = Item.name_and_price
    @@item_selected_name_and_price = prompt.select("#{@@chosen_character.name.rstrip}".yellow + ", what would you like to order?\n" + "\nPress [Enter] to add item and proceed to Checkout.\n" + "\nItems:   |   Prices:" + "\n-----------------------\n", items_list, per_page: 10)
    selected_item_name =  @@item_selected_name_and_price.slice(10...18)
    @@item_selected_for_checkout = Item.find_by_name(selected_item_name)
    OrderItem.create(order_id: current_order.id, item_id: @@item_selected_for_checkout.id)
    current_order.update(customer_seed_cost: @@item_selected_for_checkout.price)  #fix this line of code
    # current_order.update(customer_seed_cost: current_order.customer_seed_cost + @@item_selected_for_checkout.price)  #fix this line of code
    # current_order.update(deliverer_seed_payout: deliverer_seed_payout + current_order.customer_seed_cost + 5)
    current_order.update(deliverer_seed_payout: current_order.customer_seed_cost + 5)
    checkout_page
    
  end

  def self.checkout_page
    system "clear"
    current_char = @@chosen_character
    puts "Here is your order " + "#{@@chosen_character.name.rstrip}".yellow + ".\n" + "\nCart" + "\n-----------------------------\n"+ "Item:  |  Price:     " + "\n-----------------------------\n" + "#{@@item_selected_name_and_price}"
  
    selection = prompt.select("\nWhat would you like to do?") do |menu|
      menu.choice name: 'Place Order',  value: 1
      menu.choice name: 'Cancel Order',  value: 2
      # menu.choice name: 'Pick a Different Item', value: 3
    end
    current_order = @@open_order
    if selection == 1
      current_char.update(seeds: current_char.seeds - current_order.customer_seed_cost)
      current_order.update(status: "Ready for Delivery")
      loading_pending_order_page
    else selection == 2  #if adding back in edit, change to elsif
      Order.where(id: current_order.id).destroy_all
      character_page
      # elsif selection == 2
      #   @@open_order.customer_seed_cost = 0   #change to local variable?
      #   @@open_order.deliverer_seed_payout = 0 #change to local variable?  
      #   new_order_page
    end
  end

  def self.loading_pending_order_page
    #put an image here and bring back to main menu; say ___is delivering your order
    system "clear"
    current_order = @@open_order
    puts "#{current_order.deliverer.name.rstrip}".yellow + " will be delivering your order!\n"
    prompt.keypress("\nPress [Enter] to return to Character Selection menu.", key: [:enter])
    choose_character_page
  end

  def self.deliver_order_page
    system "clear"
    current_char = @@chosen_character
    order_count = current_char.orders_as_deliverer.count 
    if order_count == 0
      prompt.keypress("You currently have no deliveries. Press [Enter] to return to Character Selection menu.", key: [:enter])
      choose_character_page
    else 
    puts "Welcome " + "#{current_char.name.rstrip}".yellow + ", you currently have" + " #{order_count} order(s)".green + " to deliver."

    # pull hash of all available orders for the deliverer with string as key, and order instance as value. 
    # add payout to current_user's seed bank.
    # is there a way to add an additional menu item after the array that generated a bunch of menu items? yes == we'll need an if then before we do prompt.select

    #current_char.my_orders_as_deliverer_hash
    # "Choose your character!\n\nCharacter  | " + "Seeds ".blue + "| " + "Orders to Deliver".green + "\n--------------------------------\n", char_list, per_page: 10)
    #  binding.pry
    selection = prompt.select("\nChoose which order you want to deliver to get more seeds!\n" + "\nRecepient".yellow + "   |   " +  "Award".blue + "\n---------------------\n", current_char.my_orders_as_deliverer_hash)
    # @@current_delivery = selection
    current_char.update(seeds: current_char.seeds + selection.deliverer_seed_payout)
    selection.update(status: "Delivered")
    # @@delivered_order = @@current_delivery
    @@delivered_order = selection
    delivery_splash_page
    end 
  end

  # def self.delivery_splash_page
  #   system "clear"
  #   current_del = @@delivered_order
  #   current_char = @@chosen_character
  #   puts "You delivered #{current_del.customer.name.rstrip.yellow}'s order! You now have " + "#{current_char.seeds} seed(s)".blue + ".\n" + "\nYay, you're one step closer to saving the forest!"
  #   Order.where(id: current_del.id).destroy_all
  #   prompt.keypress("\nPress [Enter] to return to your Character Screen", key: [:enter])
  #   choose_character_page
  # end

  def self.delivery_splash_page
    system "clear"
    current_del = @@delivered_order
    current_char = @@chosen_character
    if Character.sum(:seeds) >= 220
      saved_forest_page
    else 
      pid = fork{ exec 'afplay', "./gds_music/yay_kids.mp3" } 
      Catpix::print_image "./gds_pics/delivery_pixel2.jpg",
      :limit_x => 0.5,
      :limit_y => 0,
      :center_x => true,
      :center_y => true,
      :bg => "white",
      :bg_fill => false,
      :resolution => "low"

      puts "You delivered #{current_del.customer.name.rstrip.yellow}'s order! You now have " + "#{current_char.seeds} seed(s)".blue + ".\n" + "\nYay, you're one step closer to saving the forest!"
      Order.where(id: current_del.id).destroy_all
      prompt.keypress("\nPress [Enter] to return to your Character Screen", key: [:enter])
      choose_character_page
    end 
  end

  def self.saved_forest_page
    system "clear"
    puts "Congratulations, you saved the forest from the ravaging armies! The forest spirit thanks you.".green
    pid = fork{ exec 'afplay', "./gds_music/super_mario_win.mp3" }
    Catpix::print_image "./gds_pics/characters.jpg",
      :limit_x => 1.0,
      :limit_y => 0,
      :center_x => true,
      :center_y => true,
      :bg => "white",
      :bg_fill => false
    sleep(30)
  end

  def self.prompt
    @@prompt ||= TTY::Prompt.new
  end
    
end