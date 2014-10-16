class CreateAccounts < ActiveRecord::Migration
  def change
  	unless table_exists? :accounts
	    create_table :accounts do |t|
	      t.string :password_digest
	      t.string :username

	      t.timestamps
	  	end
    end
  end
end
