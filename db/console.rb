require_relative("../models/customer")
require_relative("../models/film")
require_relative("../models/ticket")

require("pry")

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new({
  "name" => "Mike",
  "funds" => "10000"
  })
customer1.save()

customer2 = Customer.new({
  "name" => "Steve",
  "funds" => "5000"
  })
customer2.save


film1 = Film.new({
  "title" => "Jaws",
  "price" => "500"
  })
film1.save

film2 = Film.new({
  "title" => "Bladerunner",
  "price" => "650"
  })
film2.save

ticket1 = Ticket.new({
  "film_id" => film1.id,
  "customer_id" => customer1.id
  })
ticket1.save

ticket2 = Ticket.new({
  "film_id" => film2.id,
  "customer_id" => customer1.id
  })
ticket2.save

binding.pry


nil
