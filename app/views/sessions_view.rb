class SessionsView
  def ask_for(something)
    puts "Please give me #{something}"
    gets.chomp
  end

  def wrong_credentials
    puts "Sorry, wrong credentials! Try again."
  end

  def successfully_signed_in
    puts "Yeay! You're signed in!"
  end
end
