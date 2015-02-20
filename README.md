#Passion Project A: FiscAres
About the name: it is a word joke, combining Fiscaat and Ares. Here, fiscaat is the dutch word for book keeping and Ares is the name of our fraternity.


## New message, everything below this part is old

A quick overview about what is new:
* Refactored some stuff in the back end, the flow that creates manipulations and affects the associated accounts balance has changed.
* The "import a bill" function is new (login as Fiscus, pass: fiscus). In the upload page there is a sample bill you can play around with.
*  new migration added which is stepping stone to canceling a batch of manipulations as a whole
*  some other functions that worked last time might be broke, such as custom manipulation. I didn't bother fixing it because I'm going to replace it with an ajax thing anyway.


## Instructions and message to Sherif

Hi Sherif, hopefully you will like my passion project. Some instructions to get it going:

* the usual bundle install stuff is needed. Also seed the db!
* from then on, the app is available on localhost. (I decided to not build a terminal application like you said, because I felt I could learn more from making a web interface)
* There are two types of users: a treasurer and normal members. Two demo accounts are included:
	* Normal user
		username: Maurits
		password: maurits
	* Admin user
		username: Fiscus
		password: fiscus
* You can start by peeking around with Maurits. 
* After that, you may log in as the Treasurer and add yourself to the system. (The admin is the only one who can create accounts). 
* Check out models/user.rb to see what validations are built and give them a try (I didn't implement them anywhere else).
* Then try to mess around with the tools in the Admin Panel and see how they affect the member's environment.





## Introduction to the project (old)

Back home in Amsterdam, I'm with a fraternity. During our weekly gatherings, members of our fraternity don't have to bother about paying for their drinks. Instead, the treasurer of our fraternity pays a monthly bill using the fraternity's bank account, after which the costs are split up over the members depending on their attendance rate. Special events we participate in (such as proms, festivals and holidays) are also paid in advance in the same way. This means each member owes the fraternity a certain amount, which is accounted for by transferring a (mostly) fixed amount at the start of each month.

To keep this maintainable, everybody has a fraternity “bank account”, which is to say there is a very large and nasty XLS file in which the treasurer keeps track of everyone’s payments and expenses. Once in a while (by max once a month) the treasurer spreads an updated XLS file in which everyone can see their latest “withdrawals” and their current balance. Apart from the impractical constraint of having to wait for an update, the readability of the XLS file is terrible.

My goal is to digitalize the XLS file by creating a fraternity bank account application that allows the users to logon and real-time view their balance and all manipulations. Here, the treasurer will have administrative rights, which is to say he can CRUD all users, bank accounts and manipulations. 



## Note to self (to-do)

* manipulation management
	* update custom add:
		* one row: ajax validation shit,
		* one --> batch: (dont do this)
			* add/delete new row button
			* add all of year button
			* add all members button
	* WSAD-movement across textfields   CHECK
	* delete manipulations, two tabs:
		* batches: all batches of manipulations
			* show batch' nicely (post-mvp)
			* undo whole batch
			* undo specific manipulations
		* users: delete user specific manipulations
			* show 
* automailer
	* after batch completion send everyone whos balance was affected a mail with previous and current balance
		* how to calculate previous balance since manipulations are being pushed continiously?
	* notify switch that turns this function on and off
	* (post mvp) don't mail me list

* maintenance stuff 


## deleting manipulations 

# todo
	* delete manipulations, two tabs:
		* batches: all batches of manipulations
			* show batch' nicely (post-mvp)
			* undo whole batch
			* undo specific manipulations
		* users: delete user specific manipulations
			* show 
# design
* tab all users
	* bootstrap "linked items" list with members sorted per year
	* on click: dump div content, ajax load manipulations of selected user
	* generate panel for every manipulation, including undo button
	* back button at the bottem of div.
* tab all batches
  * bootstrap "badges" list with badge amount equal to amount of assiociated manipulations.
  * on click: ajax load manipulations of batch, generate panel for every manipulation of that batch.
  * stuff all those panels in a div which slides down underneath batch that is clicked. 
  * slide up button some where.
  





## manipulation management (without deleting) DONE

# todo
	* update custom add:
		* one row: ajax validation shit,
		* one --> batch: (dont do this)
			* add/delete new row button
			* add all of year button
			* add all members button


# Design 

* Menu option custom manipulations in admin panel
* starts with single row and submit button
		* add row button  --> correct & live map to JS model
		* on every row: delete row button --> correct & live map to JS model
		* ctrl + M pops up menu to auto generate rows:
				* generate row for all users
				* generate row for all users of specific year
				* for both of those: 
						* give prefill options
						* think about how to generate with respect to JS model.
		* submitting: processed manipulations in new batch.




