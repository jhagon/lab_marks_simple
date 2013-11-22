class CreateSheets < ActiveRecord::Migration
  def change
    create_table :sheets do |t|
      t.integer :student_id
      t.integer :experiment_id
      t.integer :marker_id
      t.text :comments
      t.integer :raw_mark

      t.timestamps
    end
  end
end
