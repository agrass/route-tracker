module RouteTracker
  module RouteTrackeable
    extend ActiveSupport::Concern
 
    included do
    end
 
    module ClassMethods
      def route_trackeable(options = {})
        cattr_accessor :level
        self.level = (options[:level] || "level").to_s
 
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
