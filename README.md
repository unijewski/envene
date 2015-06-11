# Envene

It's an implementation of Admin Control Panel that can be used for a simple Content Management System. We are able to manage the following sections:
* Users
    * Groups
* Tasks
    * Priorities
    * Statuses
* Posts
    * Categories

Furthermore, there is a main page called "Dashboard" where a few statistics are.

ACP also contains some clever features like:
* Gravatar images
* Live preview while writing posts and tasks
* Two available languages
    * English (default)
    * Polish
* Responsive template using Bootstrap

I hope I will develop it in the future as a fully operational system with front-end for guests or ordinary users.

You may check how it looks like [here](http://envene.herokuapp.com).
```
E-mail: admin@admin.com
Password: admin123
```

## Installation

If you want to delete fake data just remove all redundant lines below the comment in `db/seeds.rb` before the setup process.

    $ cp config/database.yml.example config/database.yml
    $ bundle install
    $ bundle exec rake db:setup
