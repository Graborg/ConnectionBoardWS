class CreateProjects < ActiveRecord::Migration
  def change
    unless table_exists? :projects
      create_table :projects do |t|
        t.string :title
        t.string :subheading
        t.text :requested_skills
        t.text :gains
        t.text :description
        t.string :time_plan
        t.datetime :created_at
        t.datetime :updated_at
        t.integer :account_id
        t.integer :show_project
        t.integer :image

        t.timestamps
      end
    end
  end
end
