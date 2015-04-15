module RouteTracker
  module RouteTrackeable
    LEVEL_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/route_tracker.yml")
    extend ActiveSupport::Concern
 
    included do
    end
 
    module ClassMethods
      def route_trackeable(options = {})
        cattr_accessor :track_level
        self.track_level = (options[:track_level] || "level").to_s
 
        include RouteTracker::RouteTrackeable::LocalInstanceMethods
      end
    end
 
    module LocalInstanceMethods
      def check_level(request)
        #write_attribute(self.class.level, request)
        p request
      end
    end
  end
end
 
ActiveRecord::Base.send :include, RouteTracker::RouteTrackeable
