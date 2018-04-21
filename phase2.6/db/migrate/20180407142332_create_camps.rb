class CreateCamps < ActiveRecord::Migration[5.1]
  def change
    create_table :camps do |t|
      t.integer :curriculum_id
      t.integer :location_id
      t.float :cost
      t.date :start_date
      t.date :end_date
      t.string :time_slot
      t.integer :max_students
      t.boolean :active

      t.timestamps
    end
  end
end
