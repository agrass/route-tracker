= RouteTracker
= Install Gem
* Add on your gemfile
```
  gem "route_tracker"
```
= Config 
* create config yml
```yaml
  POST:

  GET:
    '/resume': 2

```
* Create a new attribute to store the user track level
You need to add a migration to create an integer in your user model. For example:
```ruby
  rails g migration add_level_to_users level:integer
```
* Add route_trackeable to model (example: app/model/user.rb)
With this the model user will have the methods of route_trackeable

```
  class User < ActiveRecord::Base
    route_trackeable track_level: :level
  end
```




This project rocks and uses MIT-LICENSE.