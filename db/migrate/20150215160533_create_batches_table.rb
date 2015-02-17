class CreateBatchesTable < ActiveRecord::Migration
  def change
    create_table :batches do |t|

    	t.string 	:batch_name
      t.string 	:bill_data
 
      t.timestamps
      
 	  end
  end
end
