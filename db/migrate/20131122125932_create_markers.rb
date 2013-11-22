class CreateMarkers < ActiveRecord::Migration
  def change
    create_table :markers do |t|
      t.string :first
      t.string :last
      t.string :email
      t.string :abbr
      t.float :scaling, default: 1.0
      t.float :shift, default: 0.0
      t.boolean :admin, default: false
      t.string :encrypted_password
      t.string :salt

      t.timestamps
    end
  end
end
