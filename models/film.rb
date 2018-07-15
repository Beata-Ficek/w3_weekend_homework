require_relative('../db/sql_runner')
require_relative('customer')

class Film

  attr_accessor :title, :price, :id

  def initialize(options)
    @id = options['id'].to_i if options['id'] != nil
    @title = options['title']
    @price = options['price']
  end


  def save()
    sql = 'INSERT INTO films
    (title, price) VALUES ($1, $2) RETURNING *;'
    values = [@title, @price]
    result = SqlRunner.run(sql, values)
    @id = result.first['id'].to_i
  end

  def film()
    sql = "SELECT * FROM films WHERE id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return Film.new(result.first)
  end

  def update()
    sql = "UPDATE films
    SET title = $1, price = $2
    WHERE id = $3;"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

  def customers_who_booked()
    sql = "SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customer_id
    WHERE film_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |customers_hash| Customer.new(customers_hash) }
  end


end
# end
