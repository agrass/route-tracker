RouteTracker
=====
this gem allows you to track which routes already visited some user of your ruby on rails app. You need to specify which routes are trackable and then you can use the method `current_user.route_visited?('/resume', 'GET')` to check if the user visited that route of your web app.

Install Gem
--------------------
### Add on your Gemfile
```
  #Gemfile
  gem "route_tracker"
```
Configure
--------------------
### create config yml
You need to create a yml named route_tracker on config route (config/route_tracker.yml) and put the path name as key and the number is the identifier of that route starting from 1. (This represent the digit of the binary, this binary is used to sore a flag to then check if visited that method)
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
 **you need to be careful with the key number (track_id), used to identify the route. If you already selected one number for that route, you can't change it on production or you will get wrong data.**

### Create migration
You need to create a new migration for your user model to add an integer to storage the respective route level, to check which route already visited. (This integer is used to store as binary which route the user already visited) For example:
```ruby
  $ rails g migration add_level_to_users level:integer
```
### Add route_trackeable
With this the model user will have the methods of route_trackeable

```
  # app/models/user.rb
  class User < ActiveRecord::Base
    route_trackeable track_level: :level
  end
```
### Add route checker on application controller
You need to remplace `current_user` with your own session of user in case that you are not using devise.
```ruby
  # app/controllers/application_controller.rb 
  class ApplicationController < ActionController::Base
  
    before_filter :track_user_route
    
    def track_user_route
      reutrn if current_user.blank?
      current_user.check_route_level(request)
    end
  end
```
### Check if user visited some route
Remember to put the paths on config/route_tracker.yml with their respective track_id
```ruby
  #check if user visited index path
  current_user.route_visited?('/index')
  #check if user posted some form
  current_user.route_visited?('/form1', 'POST')
```
This project uses MIT-LICENSE.
