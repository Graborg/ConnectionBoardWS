class CreatePeople < ActiveRecord::Migration
  def change
    unless table_exists? :people
      create_table :people do |t|
        t.string :name
        t.text :expectations
        t.text :skills
        t.text :description
        t.datetime :created_at
        t.datetime :updated_at
        t.integer :account_id
        t.integer :show_profile
        t.integer :image

        t.timestamps
      end
    end
  end
end
