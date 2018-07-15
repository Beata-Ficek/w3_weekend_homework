require_relative('../db/sql_runner')
require_relative('film')
require_relative('customer')
# require_relative('customer')

class Customer

  attr_accessor :name, :funds, :id

  def initialize(options)
    @id = options['id'].to_i if options['id'] != nil
    @name = options['name']
    @funds = options['funds']
  end


  def save()
    sql = 'INSERT INTO customers
    (name, funds) VALUES ($1, $2) RETURNING *;'
    values = [@name, @funds]
    result = SqlRunner.run(sql, values)
    @id = result.first['id'].to_i
  end
  #
  def customer()
    sql = "SELECT * FROM customers WHERE id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return Customer.new(result.first)
  end
  #
  def update()
    sql = "UPDATE customers
    SET name = $1, funds = $2
    WHERE id = $3;"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end
  #
  def delete()
    sql = "DELETE FROM customers WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end

  def films_booked_by_customer()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON film_id = tickets.film_id WHERE customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |films_hash| Film.new(films_hash) }
  end
end
