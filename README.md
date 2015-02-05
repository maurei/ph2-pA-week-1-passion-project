### Passion Project A: FiscAres
About the name: it is a word joke, combining Fiscaat and Ares. Here, fiscaat is the dutch word for book keeping and Ares is the name of our fraternity.

## Introduction the project

Back home in Amsterdam, I'm with a fraternity. During our weekly gatherings, members of our fraternity don't have to bother about paying for their drinks. Instead, the treasurer of our fraternity pays a monthly bill using the fraternity's bank account, after which the costs are split up over the members depending on their attendance rate. Special events we participate in (such as proms, festivals and holidays) are also paid in advance in the same way. This means each member owes the fraternity a certain amount, which is accounted for by transferring a (mostly) fixed amount at the start of each month.

To keep this maintainable, everybody has a fraternity “bank account”, which is to say there is a very large and nasty XSL file in which the treasurer keeps track of everyone’s payments and expenses. Once in a while (by max once a month) the treasurer spreads an updated XSL file in which everyone can see their latest “withdrawals” and their current balance. Apart from the impractical constraint of having to wait for an update, the readability of the XSL file is terrible.

My goal is to digitalize the XSL file by creating a fraternity bank account application that allows the users to logon and real-time view their balance and all manipulations. Here, the treasurer will have administrative rights, which is to say he can CRUD all users, bank accounts and manipulations. 

For an MVP, I will only implement a feature that allows for manual manipulation of a specific account. Later on, I hope to add a feature that if provided with a monthly bill (.CSV), it automatically generates manipulations for all users. Also, I could implement features that allow user-to-user transfers (skipping the treasurer), a real payment feature (transfer money to the real fraternity accounts and have it automatically generate the corresponding manipulation in FiscAres) and many more.


