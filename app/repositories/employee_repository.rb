require_relative "../models/employee"
require_relative "base_repository"

class EmployeeRepository < BaseRepository

  def find_by_username(username)
    @elements.find{ |employee| employee.username == username }
  end

  undef_method :add

  def all_delivery_guys
    @elements.select{ |employee| employee.delivery_guy? }
  end

  private

  def save_csv
    CSV.open(@csv_file, "w") do |csv|
      csv << ["id", "username", "password", "role"]
      @elements.each do |employee|
        csv << [employee.id, employee.username, employee.password, employee.role]
      end
    end
  end

  def load_csv
    csv_options = {headers: :first_row, header_converters: :symbol}
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id] = row[:id].to_i
      @elements << Employee.new(row)
    end
  end
end


# csv_file   = File.join(__dir__, '../../data/employees.csv')
# employee_repo = EmployeeRepository.new(csv_file)
# p employee_repo
