# TODO: implement the router of your app.
class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
  end

  def run
    @employee = @sessions_controller.sign_in
    while @running
      if @employee.manager?
        choice = display_manager_menu
        execute_manager_actions(choice)
      else
        choice = display_delivery_menu
        execute_delivery_actions(choice)
      end
    end
  end

  private

  def display_manager_menu
    puts "What do you want to do next?"
    puts "1. List all the meals"
    puts "2. Add a meal"
    puts "3. List all the customers"
    puts "4. Add a customer"
    puts "5. List all undelivered orders"
    puts "6. Add a new order"
    puts "7. Exit the program"
    puts "8. Sign out"
    gets.chomp.to_i
  end

  def execute_manager_actions(choice)
    case choice
    when 1 then @meals_controller.list
    when 2 then @meals_controller.add
    when 3 then @customers_controller.list
    when 4 then @customers_controller.add
    when 5 then @orders_controller.list_undelivered_orders
    when 6 then @orders_controller.add
    when 7 then @running = false
    when 8 then run
    end
  end

  def display_delivery_menu
    puts "What do you want to do next?"
    puts "1. List my orders"
    puts "2. Mark an order as delivered"
    puts "3. Exit the program"
    puts "4. Sign out"
    gets.chomp.to_i
  end

  def execute_delivery_actions(choice)
    case choice
    when 1 then @orders_controller.list_my_orders(@employee)
    when 2 then @orders_controller.mark_as_delivered(@employee)
    when 3 then @running = false
    when 4 then run
    end
  end
end

























