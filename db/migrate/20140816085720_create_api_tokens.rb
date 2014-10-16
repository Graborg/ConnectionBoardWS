class CreateApiTokens < ActiveRecord::Migration
  def change
  	unless table_exists? :api_tokens
	    create_table :api_tokens do |t|
	      t.string :access_token
	      t.integer :account_id

	      t.timestamps
		end
    end
  end
end
