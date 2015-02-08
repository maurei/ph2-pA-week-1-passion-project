#Passion Project A: FiscAres
About the name: it is a word joke, combining Fiscaat and Ares. Here, fiscaat is the dutch word for book keeping and Ares is the name of our fraternity.

## Introduction to the project

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


### features

* users can (and must) logon to see anything. 
* landing page after login
	* shows top 5 positive and negative balances 
		* if normal member: show account information and list of all transactions
		* if treasurer: show control panel
			* CRUD user
			* list of all users with their balances
			* show user specific manipulation list + account info
			* manual manipulation form: update a users account

I guess this is my MVP. Validations and and (validation) errors will be handled nicely, (some) tests will be written. Then I would like to implement some AJAX, And after that, all remaining time I will spend on making it pretty, but probably not after all of the above functionality is in there.



---------------------------------------------------------------

To do:

* Auth controller
	- standard stuff als creating user (mainly copy paste)
	- setting up corresponding routes and pages for that
	- add minimal conditional logic in terms of what page is to show next

Assuming that associations are built already:

Thought: 
Everyone has an account, (maybe of several types - post mvp though). Only thing that is relevant is how much goes into account (member transfers money) and how much is withdrawn (treasurer makes invoice).

DONT CARE ABOUT WHERE MONEY GOES

DONT CARE ABOUT MORE THAN 1 ACCOUNT
<!-- Where money goes to is not important for now.
Maybe, when making other types of accounts like a prom account, members start at -100% and accountadmin starts at zero. all manipulations in favor of member gets mirrored to account-admins account
 -->

* Accounts 
	- class methods that:
		- decrease a users balance
		- increase a balance
		- mass edit?
				- per year
				- all
				- custom
		- maybe something that combines both in order to keep track of  (post mvp?)


