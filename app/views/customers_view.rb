class CustomersView
  def display_all(customers)
    customers.each do |customer|
      puts "#{customer.id} - #{customer.name}: #{customer.address}"
    end
  end

  def ask_for(something)
    puts "Give me a #{something}"
    gets.chomp
  end
end
