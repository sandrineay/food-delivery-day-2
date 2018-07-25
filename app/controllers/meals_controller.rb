require_relative "../views/meals_view"
require_relative "../models/meal"

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def add
    # 1. Ask user for name
    name = @meals_view.ask_for("name")
    # 2. Ask user for a price
    price = @meals_view.ask_for("price").to_i
    # 3. Add it to the repo
    new_meal = Meal.new(name: name, price: price)
    @meal_repository.add(new_meal)
  end

  def list
    # 1. Fetch all the meals from repo
    meals = @meal_repository.all
    # 2. Display all these meals to the view
    @meals_view.display_all(meals)
  end
end
