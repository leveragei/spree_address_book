module Authentication
  def sign_in!(user)
    puts "user.email: #{user.email.inspect}"
    fill_in "spree_user_email", with: user.email
    fill_in "spree_user_password", with: "secret"
    click_on "Login"
  end
end

RSpec.configure do |c|
  c.include Authentication, type: :feature
end
