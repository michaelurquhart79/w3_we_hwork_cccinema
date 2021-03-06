require_relative("../db/sql_runner")
require_relative("film")
require_relative("ticket")

class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @name = options["name"]
    @funds = options["funds"].to_i
    @id = options["id"].to_i if options["id"]
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    result = SqlRunner.run(sql, values)[0]
    @id = result["id"].to_i
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films
    INNER JOIN tickets ON films.id = tickets.film_id
    WHERE tickets.customer_id = $1"
    values = [@id]
    films_array = SqlRunner.run(sql, values)
    return films_array.map{|film| Film.new(film)}
  end

  def buy_ticket(film)
    if @funds >= film.price
      @funds -= film.price
      update()
      ticket_options = {
        "film_id" => film.id,
        "customer_id" => @id
      }
      ticket = Ticket.new(ticket_options)
      ticket.save
    end

  end

  def number_of_tickets()
    sql = "SELECT * FROM tickets WHERE customer_id = $1"
    values = [@id]
    tickets = SqlRunner.run(sql, values)
    return tickets.ntuples()
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    return customers.map{|customer| Customer.new(customer)}
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    customer_hash = SqlRunner.run(sql, values)[0]
    return Customer.new(customer_hash)
  end

end
