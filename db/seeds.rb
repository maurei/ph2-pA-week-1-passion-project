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

wensvoort = {
      handle: "Nick Wensvoort",
      password: "nick",
      email: "nick@gmail.com",
      access_level: "member",
      year: 2014
}

brackel = {
      handle: "Tom Brackel",
      password: "tom",
      email: "tom@gmail.com",
      access_level: "member",
      year: 2014
}

mees = {
      handle: "Mees Koningswijk",
      password: "mees",
      email: "mees@gmail.com",
      access_level: "member",
      year: 2014
}



fiscus = {
      handle: "Treasurer",
      password: "Treasurer",
      email: "ares@fiscus.nl",
      access_level: "superadmin",
      year: 2012
}

users = [mees, wensvoort, arendo, maurits, fiscus]

users.map! do |user|
	user = User.create(user)
      user.create_account(balance: 0.0) unless user.access_level == "superadmin"
      user
      end

users.pop

users.each do |user|
       user.account.manipulate(amount: 80.00, issue_date: "2015/01/01", description: "Periodieke overboeking", action: "deposit")
      end


