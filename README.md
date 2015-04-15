RouteTracker
=====
this gem allows you to track which routes already visited some user of your ruby on rails app. 

Install Gem
--------------------
### Add on your gemfile
```
  gem "route_tracker"
```
Configure
--------------------
### create config yml
You need to create a yml named route_tracker on config route (config/route_tracker.yml)
```yaml
  #config/route_tracker.yml
  #
  POST:
    '/post1': 1
    '/post1': 2
    #'/urlname': track_id
  GET:
    '/get1': 3
    '/get1': 4

```
### Create a new attribute to store the user track level
You need to add a migration to create an integer in your user model. For example:
```ruby
  rails g migration add_level_to_users level:integer
```
### Add route_trackeable to model (example: app/model/user.rb)
With this the model user will have the methods of route_trackeable

```
  class User < ActiveRecord::Base
    route_trackeable track_level: :level
  end
```




This project rocks and uses MIT-LICENSE.
