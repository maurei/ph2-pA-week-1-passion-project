class CreateAccountsTable < ActiveRecord::Migration
  def change
  	create_table :accounts do |t|

  		t.float 	:balance
  		t.string	:account_type
  		
  		t.integer :user_id
  		
  		t.timestamps

  	end
  end
end
