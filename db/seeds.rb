require_relative "../config/environment.rb"

arendo = {
      handle: "Arendo van Hulsbergen",
      password: "arendo",
      email: "aad@mail.com",
      access_level: "member",
      year: 2012
}

maurits = {
      handle: "Maurits Moeys",
      password: "maurits",
      email: "maurits.moeys@gmail.com",
      access_level: "member",
      year: 2012
}

diederik = {
      handle: "Diederik van der Hoek",
      password: "diederik",
      email: "died@mail.com",
      access_level: "member",
      year: 2012
}

marijn = {
      handle: "Marijn te Poel",
      password: "marijn",
      email: "marijn@mail.com",
      access_level: "member",
      year: 2012
}

haye = {
      handle: "Haye Liefferink",
      password: "haye",
      email: "hayuh@mail.com",
      access_level: "member",
      year: 2012
}

steven = {
      handle: "Steven Vogel",
      password: "steven",
      email: "vogel@mail.com",
      access_level: "member",
      year: 2012
}

jesse = {
      handle: "Jesse Gilling",
      password: "jesse",
      email: "gilling@mail.com",
      access_level: "member",
      year: 2012
}

tom = {
      handle: "Tom Schrikkema",
      password: "tom",
      email: "schrikkel@mail.com",
      access_level: "member",
      year: 2012
}



fiscus = {
      handle: "Fiscus",
      password: "fiscus",
      email: "fiscus@mail.com",
      access_level: "superadmin",
      year: 1923
}

users = [maurits, diederik, tom, jesse, arendo, haye, steven, marijn, fiscus]

users.each {|x| User.create(x) }

# users.pop

# users.each do |user|
#        user.account.manipulate(amount: 80.00, issue_date: "2015/01/01", description: "Periodieke overboeking", action: "deposit")
#       end


