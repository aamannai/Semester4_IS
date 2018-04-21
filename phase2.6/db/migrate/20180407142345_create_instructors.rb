class CreateInstructors < ActiveRecord::Migration[5.1]
  def change
    create_table :instructors do |t|
      t.string :first_name
      t.string :last_name
      t.text :bio
      t.string :email
      t.string :phone
      t.boolean :active

      t.timestamps
    end
  end
end
