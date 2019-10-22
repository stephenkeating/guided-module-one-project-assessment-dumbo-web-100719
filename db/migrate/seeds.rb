Character.destroy_all
Item.destroy_all

#Characters Data

@ponyo = Character.create(name: "Ponyo", seeds: 10)
@noface = Character.create(name: "Noface", seeds: 10)
@sophie = Character.create(name: "Sophie", seeds: 10)
@calcifer = Character.create(name: "Calcifer", seeds: 10)
@satsuki = Character.create(name: "Satsuki", seeds: 10)
@mei = Character.create(name: "Mei", seeds: 10)
@kiki = Character.create(name: "Kiki", seeds: 10)
@totoro = Character.create(name: "Totoro", seeds: 10)
@haku = Character.create(name: "Haku", seeds: 10)
@howl = Character.create(name: "Howl", seeds: 10)
@catbus = Character.create(name: "Catbus", seeds: 10)

#Items Data

@ham = Item.create(name: "Ham", price: 2)
@gold = Item.create(name: "Gold", price: 5)
@eggs = Item.create(name: "Eggs", price: 1)
@bacon = Item.create(name: "Bacon", price: 3)
@coal = Item.create(name: "Coal", price: 4)
@umbrella = Item.create(name: "Umbrella", price: 6)
@toy_boat = Item.create(name: "Toy Boat", price: 8) 
@hat = Item.create(name: "Hat", price: 7)

#Orders -- optional seed

@order_1 = Order.create(customer_seed_cost: )