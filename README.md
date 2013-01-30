# Character

**Character** is a **Rails**/**CoffeeScript**/**SASS** administration library build with **Backbone.js** and **Foundation**.


## What's inside?


## Setup

Start a new Rails project: ```$ rails new appname -T -O```. Update your ```Gemfile``` by adding these gems:

    # Mongoid
    gem 'bson_ext'
    gem 'mongoid'

    # Character
    gem 'rmagick'
    gem 'character', git: 'git://github.com/alexkravets/character-rails.git', branch: 'admin'

Make sure that in the begining of ```Gemfile``` you have ruby version line: ```ruby '1.9.3'``` - this is **required** for **mongoid v3** gem.

Generate mongoid configuration with: ```rails generate mongoid:config``` command, add **production** configuration for heroku:

    production:
      sessions:
        default:
          uri: <%= ENV['MONGOLAB_URI'] %>

Generate admin assets to be used in the new projects:

...

Add pages, blog and admin app routes to the ```config/routes.rb``` file:

  mount_character_admin()
  mount_character_pages()
  mount_character_blog_at('/blog')

Remove ```public/index.html``` file.


Add website name to the development and production environment using **WEBSITE_NAME** setting.

Add first admin user via console: ```Character::AdminUser.create! email:'santyor@gmail.com'``` 









## How to?


## Credentials


## TODO

**Styles:**
 - Login page styles (browserid)
 - Image uploader style for markdown editor

**Features:**
 - Select image size (checkbox if scaled version should be used) when uploading image (redactor/markdown)
 - Open Graph support out of the box
 - Set page _position when creating new
 - Remove page function
 - Moving page element
 - Add search functionality on index view
 - Settings app out of the box
 - General data loading mechanics for apps
 - Default admin app generator for mongoid model
 - Isolate browserid
 - Add filters/categories for the blog
 - Filter which converts local images paths to S3 hosted
 - integrate fitvids into markdown editor


