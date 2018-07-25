class MealsView
  def display_all(meals)
    meals.each do |meal|
      puts "#{meal.id} - #{meal.name}: #{meal.price}"
    end
  end

  def ask_for(something)
    puts "Give me a #{something}"
    gets.chomp
  end
end
