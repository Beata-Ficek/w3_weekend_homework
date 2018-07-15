require_relative('../db/sql_runner')
require_relative('customer')

class Ticket

attr_reader :id
attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id'] != nil
    @film_id = options['film_id'].to_i
    @customer_id = options['customer_id'].to_i
  end


  def save()
    sql = 'INSERT INTO tickets
    (film_id, customer_id) VALUES ($1, $2) RETURNING *;'
    values = [@film_id, @customer_id]
    result = SqlRunner.run(sql, values)
    @id = result.first['id'].to_i
  end

  def tickets()
    sql = "SELECT * FROM tickets WHERE id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return Ticket.new(result.first)
  end
  #
  def update()
    sql = "UPDATE tickets
    SET film_id = $1, customer_id = $2
    WHERE id = $3;"
    values = [@film_id, @customer_id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end


end
