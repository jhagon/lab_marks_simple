Needed to add `therubyracer` runtime js library to get most rails commands
to work properly:

```
gem 'therubyracer'
```

This database has 4 tables: students, markers, experiments and sheets.
Commands used were:

```
rails g scaffold Experiment title:string description:string
rails g scaffold Student number:string first:string last:string email:string
rails g scaffold Marker first:string last:string email:string abbr:string \
        scaling:float shift:float admin:boolean encrypted_password:string \
        salt:string
rails g scaffold Sheet student_id:integer experiment_id:integer \
        marker_id:integer comments:text raw_mark:integer
```

Needed to modify the generated migration file for markers, to set some 
defaults:

```
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
```
