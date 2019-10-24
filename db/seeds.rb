Character.destroy_all
Item.destroy_all
Order.destroy_all
OrderItem.destroy_all

#Characters Data

ponyo = Character.create(name: "Ponyo   ", seeds: 20)
noface = Character.create(name: "Noface  ", seeds: 20)
sophie = Character.create(name: "Sophie  ", seeds: 20)
calcifer = Character.create(name: "Calcifer", seeds: 20)
satsuki = Character.create(name: "Satsuki ", seeds: 20)
# mei = Character.create(name: "Mei     ", seeds: 20)
kiki = Character.create(name: "Kiki    ", seeds: 20)
totoro = Character.create(name: "Totoro  ", seeds: 20)
haku = Character.create(name: "Haku    ", seeds: 20)
howl = Character.create(name: "Howl    ", seeds: 20)
catbus = Character.create(name: "Catbus  ", seeds: 20)

#Items Data

ham = Item.create(name: "Ham     ", price: 2)
gold = Item.create(name: "Gold    ", price: 5)
eggs = Item.create(name: "Eggs    ", price: 1)
bacon = Item.create(name: "Bacon   ", price: 3)
coal = Item.create(name: "Coal    ", price: 4)
umbrella = Item.create(name: "Umbrella", price: 6)
toy_boat = Item.create(name: "Toy Boat", price: 8) 
hat = Item.create(name: "Hat     ", price: 7)

#Orders -- optional seed, to be deleted before playing the game
# Order.create(customer: ponyo, deliverer: noface, customer_seed_cost: 5, deliverer_seed_payout: 7, status: "open")
# Order.create(customer: noface, deliverer: mei, customer_seed_cost: 5, deliverer_seed_payout: 7, status: "Ready for Delivery")


# @order_1 = Order.create(customer_id: 1, deliverer_id: 2, customer_seed_cost: 5, deliverer_seed_payout: 7)
# @order_2 = Order.create(customer_id: 1, deliverer_id: 4, customer_seed_cost: 2, deliverer_seed_payout: 7)