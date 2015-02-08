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
      handle: "Ares Fiscus",
      password: "ares",
      email: "ares@fiscus.nl",
      access_level: "superadmin",
      year: 2012
}

users = [arendo, maurits, fiscus]

users.each do |user|
	user = User.create(user)
	Account.create(balance: 0.0, account_type: "PD", user_id: user.id)
end