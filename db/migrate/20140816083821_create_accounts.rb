class CreateAccounts < ActiveRecord::Migration
  def change
	    create_table :accounts do |t|
	      t.string :password_digest
	      t.string :username

	      t.timestamps
    end
  end
end
