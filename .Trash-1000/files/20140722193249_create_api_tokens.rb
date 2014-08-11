class CreateApiTokens < ActiveRecord::Migration
  def change
    create_table :api_tokens do |t|
      t.string :access_token
      t.integer :account_id

      t.timestamps
    end
  end
end
