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

Added some default header and footer pages in `app/views/layouts`.
Therer are 4 files in this directory:

```
application.html.erb  _footer.html.erb  _header.html.erb  _shim.html.erb
```

The `is_admin?` function referred to in the `application.html.erb` file
is disabled initially. It will be added later.
The contents of the files look like this:


```
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= title %></title>
    <%= stylesheet_link_tag "application", media: "all",
                                           "data-turbolinks-track" => true %>
    <%= javascript_include_tag :defaults %>
    <%= javascript_include_tag "application", "data-turbolinks-track" => true %>
    <%= csrf_meta_tags %>
    <%= render 'layouts/shim' %>
  </head>
  <body>
      <%= render 'layouts/header' %>
      <div class="container">
        <% flash.each do |key,value| %>
          <div class="alert alert-<%= key %>"><%= value %></div>
        <% end %>
        <%= yield %>
      </div>
      <%= render 'layouts/footer' %>
    </div>
  </body>
</html>


<footer class="footer">
  <div class="container">

  <small>
    LabMarks v0.1 JPH
  </small>
<!--  <nav>
    <% if is_admin? %>
    <ul>
    <li><%= link_to "Mark List",    "/marklist" %></li>
    <li><%= link_to "Statistics",    "/statistics" %></li>
    <li><%= link_to "Experiments",    experiments_path %></li>
    <li><%= link_to "Mark Sheets",    sheets_path %></li>
    <li><%= link_to "Students",    students_path %></li>
    <li><%= link_to "Markers",    markers_path %></li>
    </ul>
    <% else %>
    <ul>
    <li><%= link_to "About",    about_path %></li>
    <li><%= link_to "Contact",    contact_path %></li>
    </ul>
    <% end %>
  </nav> -->
    <%= debug(params) if Rails.env.development? %>
  </div>
</footer>

<header class="navbar navbar-fixed-top navbar-inverse">
  <div class="navbar-inner">
    <div class="container">
      <%= link_to root_path, id: "logo" do %>
        <span style="color:#f00;">Lab</span><span style="color:#66f;">Marks</span>
      <% end %>

      <nav>
    <ul class="nav pull-right">
    <% if signed_in? %>

     <li> <%= link_to "Signed in as #{@current_marker.first} #{@current_marker.last}",  current_marker %></li>

      <li id="fat-menu" class="dropdown">
        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
Account<b class="caret"></b></a>
              <ul class="dropdown-menu">
                <li><%= link_to "Profile", current_marker %></li>
                <li><%= link_to "Help",    help_path %></li>
                <li><%= link_to "About",    about_path %></li>
    <% if is_admin? %>
                <li class="divider"></li>
    <li><%= link_to "Mark List",    "/marklist" %></li>
    <li><%= link_to "Statistics",    "/statistics" %></li>
    <li><%= link_to "Experiments",    experiments_path %></li>
    <li><%= link_to "Mark Sheets",    sheets_path %></li>
    <li><%= link_to "Students",    students_path %></li>
    <li><%= link_to "Markers",    markers_path %></li>
    <li><%= link_to "Data Upload",    upload_path %></li>
    <% end %>

                <li class="divider"></li>
                <li>
                  <%= link_to "Sign out", signout_path, method: "delete" %>
                </li>
              </ul>
            </li>
    <% else %>
      <li><%= link_to "Home",    root_path %></li>
      <li><%= link_to "About",    about_path %></li>
    <% end %>
    <% unless signed_in? %>
      <li><%= link_to "Sign in", signin_path %></li>
    <% end %>

    </ul>
      </nav>
    </div>
  </div>
</header>

<!--[if lt IE 9]>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->

```

For drop-down menu, need to add the line:

```
//= require bootstrap
```

to the file `app/assets/javascripts/application.js`.
