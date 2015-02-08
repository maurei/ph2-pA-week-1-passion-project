require_relative "../config/environment.rb"

arendo = {
      handle: "Arendo",
      password: "Arendo",
      email: "arendo@mail.com",
      access_level: "member",
      year: 2012
}

maurits = {
      handle: "Maurits",
      password: "Maurits",
      email: "maurits@mail.com",
      access_level: "member",
      year: 2012
}

fiscus = {
      handle: "Fiscus",
      password: "fiscus",
      email: "ares@fiscus.nl",
      access_level: "superadmin",
      year: 2012
}

users = [arendo, maurits, fiscus]

users.map! do |user|
	user = User.create(user)
	Account.create(balance: 0.0, account_type: "PD", user_id: user.id) unless user.access_level == "superadmin"
      user
end

users.pop

users.each do |user|
      user.accounts.each do |account_of_user|
            account_of_user.manipulate(amount: 80.00, issue_date: "2015/01/01", description: "Periodieke overboeking", action: "deposit")
      end
end

users.each do |user|
      user.accounts.each do |account_of_user|
            5.times do
                  amount = rand(10.00...20.00).round(2)
                  account_of_user.manipulate(amount: amount, issue_date: "2015/01/01", description: "Periodieke overboeking", action: "withdraw")
            end
      end
end
