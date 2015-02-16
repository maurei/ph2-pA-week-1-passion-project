class CreateBatchManipulationsTable < ActiveRecord::Migration
  def change
    create_table :batch_manipulations do |t|

      t.string 	:batch_json
 
      t.timestamps
      
 	  end
  end
end
