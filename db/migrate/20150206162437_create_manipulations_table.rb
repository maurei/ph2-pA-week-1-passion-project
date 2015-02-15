class CreateManipulationsTable < ActiveRecord::Migration
  def change
    create_table :manipulations do |t|

    	t.float		:amount # make this an integer @TODO
      t.date		:issue_date     
      t.string 	:action
      t.string  :description
      
			t.integer :account_id

      t.timestamps
      
    end
  end
end

