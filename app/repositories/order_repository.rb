require "csv"
require_relative "../models/order"

class OrderRepository
  def initialize(csv_file, meal_repository, employee_repository, customer_repository)
    @csv_file = csv_file
    @orders = []
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    load_csv if File.exists?(@csv_file)
  end

  def undelivered_orders
    @orders.reject{ |order| order.delivered? }
  end

  def add(order)
    next_id = @orders.empty? ? 1 : @orders.last.id + 1
    order.id = next_id
    @orders << order
    save_csv
  end

  def find(id)
    @orders[id - 1]
  end

  def save_csv
    CSV.open(@csv_file, "w") do |csv|
      csv << ["id", "delivered", "meal_id", "customer_id", "employee_id"]
      @orders.each do |order|
        csv << [order.id, order.delivered, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end

  private

  def load_csv
    csv_options = {headers: :first_row, header_converters: :symbol}
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == "true"
      new_order = Order.new(row)
      # Fetch in the meal repository the instance of Meal that corresponds to row[:meal_id].to_i
      meal = @meal_repository.find(row[:meal_id].to_i)
      new_order.meal = meal
      customer = @customer_repository.find(row[:customer_id].to_i)
      new_order.customer = customer
      employee = @employee_repository.find(row[:employee_id].to_i)
      new_order.employee = employee
      @orders << new_order
    end
  end
end
