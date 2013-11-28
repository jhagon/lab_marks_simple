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

Bundle
======
Might need to do a `bundle install` in the deployment directory.

Initializing a New Production Database
====================================
The correct order to setup database in production, with all the rake task
available within db namespace is as below

```
$rake db:create RAILS_ENV=production
$rake db:migrate RAILS_ENV=production
$ rake db:seed RAILS_ENV=production
```

Stylesheets and Image Assets
============================
To get assets such as images, stylesheets served, may need to set these
in `production.rb`.

```
config.assets.compress = true
config.assets.compile = true
config.assets.digest = true
config.assets.initialize_on_precompile = false
```

Will_Paginate in Production Mode
================================
For some reason, Will_Paginate does not read its default PER_PAGE from the
`config/environment.rb` file. Had to put

```
WillPaginate.per_page = 10
```

in the `config/environments/production.rb` file to get it to work.

