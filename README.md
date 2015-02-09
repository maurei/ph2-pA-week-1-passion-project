#Passion Project A: FiscAres
About the name: it is a word joke, combining Fiscaat and Ares. Here, fiscaat is the dutch word for book keeping and Ares is the name of our fraternity.

## Instructions and message to Sherif

Hi Sherif, hopefully you will like my passion project. Some instructions to get it going:

* the usual bundle install stuff is needed. Also seed the db!
* from then on, the app is available on localhost. (I decided to not build a terminal application like you said, because I felt I could learn more from making a web interface)
* There are two types of users: a treasurer and normal members. Two demo accounts are included:
	* Normal user
		username: Maurits
		password: Maurits
	* Admin user
		username: Treasurer
		password: Treasurer
* You can start by peeking around with Maurits. 
* After that, you may log in as the Treasurer and add yourself to the system. (The admin is the only one who can create accounts). 
* Check out models/user.rb to see what validations are built and give them a try (I didn't implement them anywhere else).
* Then try to mess around with the tools in the Admin Panel and see how they affect the member's environment.

### Some notes about the code

Honestly, I'm not very happy with the end result. Time is running out, I need to save some energy for upcoming week so I decided not to rabbit hole too much on most stuff. I'm mostly not happy about the routes. 

It felt very counter intuitive to stick to the RESTful convention at some points. For example, when editting a manipulation, I wanted to first show a list of users to select whose transactions you wanted to mess with. But according to RESTful routing, that page should be /users. But I already had that route with different variables in them for editting users, so I would either have to merge those two pages in a clever way (doable but I didnt want to), or avoid using a restful route, which is what I did. Probably, there is a correct RESTFul way to do it, but seem to not be comfortable with using the flexibilty of the RESTful routing convention. So yeah, I think my routing is a bit of a mess.



## Introduction to the project (old)

Back home in Amsterdam, I'm with a fraternity. During our weekly gatherings, members of our fraternity don't have to bother about paying for their drinks. Instead, the treasurer of our fraternity pays a monthly bill using the fraternity's bank account, after which the costs are split up over the members depending on their attendance rate. Special events we participate in (such as proms, festivals and holidays) are also paid in advance in the same way. This means each member owes the fraternity a certain amount, which is accounted for by transferring a (mostly) fixed amount at the start of each month.

To keep this maintainable, everybody has a fraternity “bank account”, which is to say there is a very large and nasty XLS file in which the treasurer keeps track of everyone’s payments and expenses. Once in a while (by max once a month) the treasurer spreads an updated XLS file in which everyone can see their latest “withdrawals” and their current balance. Apart from the impractical constraint of having to wait for an update, the readability of the XLS file is terrible.

My goal is to digitalize the XLS file by creating a fraternity bank account application that allows the users to logon and real-time view their balance and all manipulations. Here, the treasurer will have administrative rights, which is to say he can CRUD all users, bank accounts and manipulations. 

For an MVP, I will only implement a feature that allows for manual manipulation of a specific account. Later on, I hope to add a feature that if provided with a monthly bill (.CSV), it automatically generates manipulations for all users. Also, I could implement features that allow user-to-user transfers (skipping the treasurer), a real payment feature (transfer money to the real fraternity accounts and have it automatically generate the corresponding manipulation in FiscAres) and many more.

## About the design (approval needed)

### Tables/models

#### Users table

* all personal info
* acces level (member or treasurer)

#### Accounts table

Belongs to user

Has many manipulations

* account info
* balance


#### Manipulations

Belongs to account

* manipulation value
* corresponding event
* date of corresponding event
* additional description




