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












brackel = {
      handle: "Tom Brackel",
      password: "tom",
      email: "tom@mail.com",
      access_level: "member",
      year: 2013
}

schultz = {
      handle: "Lucas Schultz",
      password: "lucas",
      email: "lucas@mail.com",
      access_level: "member",
      year: 2013
}

mees = {
      handle: "Mees Koningswijk",
      password: "mees",
      email: "mees@mail.com",
      access_level: "member",
      year: 2013
}

friso = {
      handle: "Friso Hoving",
      password: "friso",
      email: "friso@mail.com",
      access_level: "member",
      year: 2013
}

teun = {
      handle: "Teun Grijzenhout",
      password: "teun",
      email: "teun@mail.com",
      access_level: "member",
      year: 2013
}

richard = {
      handle: "Richard bredeveld",
      password: "richard",
      email: "richard@mail.com",
      access_level: "member",
      year: 2013
}

yoloost = {
      handle: "Joost Broekhoven",
      password: "joost",
      email: "joost@mail.com",
      access_level: "member",
      year: 2013
}

steve = {
      handle: "Steve Nugteren",
      password: "steve",
      email: "steve@mail.com",
      access_level: "member",
      year: 2013
}









fiscus = {
      handle: "Fiscus",
      password: "fiscus",
      email: "fiscus@mail.com",
      access_level: "superadmin",
      year: 1923
}

users = [maurits, diederik, tom, jesse, arendo, haye, steven, marijn, fiscus, brackel, schultz, mees, friso, teun, richard, yoloost, steve]

users.each {|x| User.create(x) }

# users.pop

# users.each do |user|
#        user.account.manipulate(amount: 80.00, issue_date: "2015/01/01", description: "Periodieke overboeking", action: "deposit")
#       end


