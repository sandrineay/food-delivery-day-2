require_relative "../views/customers_view"
require_relative "../models/customer"

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def add
    # 1. Ask user for name
    name = @customers_view.ask_for("name")
    # 2. Ask user for an address
    address = @customers_view.ask_for("address")
    # 3. Add it to the repo
    new_customer = Customer.new(name: name, address: address)
    @customer_repository.add(new_customer)
  end

  def list
    # 1. Fetch all the customers from repo
    customers = @customer_repository.all
    # 2. Display all these customers to the view
    @customers_view.display_all(customers)
  end
end
