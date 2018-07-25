require_relative "../models/customer"
require_relative "base_repository"

class CustomerRepository < BaseRepository

  private

  def save_csv
    CSV.open(@csv_file, "w") do |csv|
      csv << ["id", "name", "address"]
      @elements.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end

  def load_csv
    csv_options = {headers: :first_row, header_converters: :symbol}
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id] = row[:id].to_i
      @elements << Customer.new(row)
    end
  end
end
