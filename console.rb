require_relative('models/film')
require_relative('models/customer')
require_relative('models/ticket')

Film.delete_all()
Customer.delete_all()
Ticket.delete_all()


film1 = Film.new(
  {"title" => "Deadpool 2",
    "price" => 10}
)

film2 = Film.new(
  {"title" => "The Game",
    "price" => 12}
)

# SAVE TEST
film1.save()
film2.save()

# TEST FILM
# p film1.film()

# TEST UPDATE
# film1.title = "The Bee Movie"
# film1.update()

# TEST DELETE
# film1.delete()




customer1 = Customer.new(
{"name" => "Marta Kotonska",
  "funds" => 30}
)
customer2 = Customer.new(
{"name" => "Lizzy Gaskell",
  "funds" => 20}
)

# SAVE TEST
customer1.save()
customer2.save()
#
# # TEST CUSTOMER
# p customer1.customer()

# TEST UPDATE
# customer1.name = "Klaudia Owsianka"
# customer1.update()

# TEST DELETE
# customer1.delete()



ticket1 = Ticket.new(
{"film_id" => film1.id,
"customer_id" => customer1.id}
)

ticket2 = Ticket.new(
{"film_id" => film2.id,
"customer_id" => customer2.id}
)

ticket3 = Ticket.new(
{"film_id" => film2.id,
"customer_id" => customer1.id}
)


# TEST SAVE
ticket1.save()
ticket2.save()
ticket3.save()


# TEST films_booked
# film1.customers().each{ |customer| puts customer.name}
# p film2.customers_who_booked
p customer1.films_booked_by_customer
