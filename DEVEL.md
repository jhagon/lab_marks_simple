Useful Gems
===========
Need to install `therubyracer` gem (or another js runtime library) before
most rails 4 commands will work:

```
gem 'therubyracer'
```

In order to use old-style protected attributes (attr_accessible etc) in models
we use this gem:

```
gem 'protected_attributes'
```

To use older style error routines use this gem:

```
gem 'dynamic_form'
```

Use will_paginate to paginate index pages:
```
gem 'will_paginate', '~> 3.0'
```

Use bootstrap-sass for improved CSS structure and appearance
```
gem 'bootstrap-sass'
```

Created four tables: Sheet, Student, Experiment and Marker.

Installed the 'annotate' gem to annotate models:

```
gem 'annotate'
```

Then used the command:

```
annotate --exclude tests,fixtures,factories
```

to annotate the model files defining the tables.

Models Used
===========
Here are the basic model definitions:

````
class Experiment < ActiveRecord::Base
end

# == Schema Information
#
# Table name: experiments
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Marker < ActiveRecord::Base
end

# == Schema Information
#
# Table name: markers
#
#  id                 :integer         not null, primary key
#  first              :string(255)
#  last               :string(255)
#  email              :string(255)
#  abbr               :string(255)
#  scaling            :float           default(1.0)
#  shift              :float           default(0.0)
#  admin              :boolean         default(FALSE)
#  encrypted_password :string(255)
#  salt               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class Student < ActiveRecord::Base
end

# == Schema Information
#
# Table name: students
#
#  id         :integer         not null, primary key
#  number     :string(255)
#  first      :string(255)
#  last       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Sheet < ActiveRecord::Base
end

# == Schema Information
#
# Table name: sheets
#
#  id            :integer         not null, primary key
#  student_id    :integer
#  experiment_id :integer
#  marker_id     :integer
#  comments      :text
#  raw_mark      :integer
#  created_at    :datetime
#  updated_at    :datetime
#
```

Static Pages
============
A number of static pages will be required, so we first create a special
controller to handle the requests and define the route for each page
in the route.rb file. the controller for the home, contact, about, help,
statistics, marklist and upload pages is generated via:

```
rails generate controller StaticPages home contact help about \
  ststistics marklist upload --no-test-framework
```
The `--no-test-framework` option prevents the creation of any tests.
The above command creates the appropriate routes in `config/route.rb` and
creates stub views for each page action in `app/views/static_pages`.

note that we have passed the controller name as so-called CamelCase, which 
leads to the creation of a controller file written in snake case, so that a 
controller called StaticPages yields a file called static_pages_controller.rb. 
This is merely a convention, and in fact using snake case at the command line 
also works.
