require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @sessions_view = SessionsView.new
    @employee_repository = employee_repository
  end

  def sign_in
    # 1. Ask user for a username
    username = @sessions_view.ask_for("username")
    # 2. Ask user for a password
    password = @sessions_view.ask_for("password")
    # 3. Fetch the user in the employee repository
    employee = @employee_repository.find_by_username(username)
    if employee && employee.password == password
      @sessions_view.successfully_signed_in
      return employee
    else
      # 1. Tell the user the credentials are wrong
      @sessions_view.wrong_credentials
      # 2. Give him the opportunity to sign in again
      sign_in
    end
    # 4. Check if the password matches the record
  end
end
