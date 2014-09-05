class SetNullChecksAfterAccountsCreation < ActiveRecord::Migration
  def change
	change_column_null :accounts, :password_digest, false
	change_column_null :accounts, :username, false
	add_index :accounts, :username, :unique => true
	
	change_column_null :api_tokens, :access_token, false
	change_column_null :api_tokens, :account_id, false
	add_index :api_tokens, :account_id, :unique => true

	change_column_null :people, :account_id, false
	change_column_null :people, :show_profile, false
	change_column_null :people, :image, false
	add_index :people, :account_id, :unique => true

	change_column_null :projects, :account_id, false
	change_column_null :projects, :show_project, false
	change_column_null :projects, :image, false
  end
end
