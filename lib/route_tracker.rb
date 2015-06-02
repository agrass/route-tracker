module RouteTracker
  module RouteTrackeable
    LEVEL_CONFIG = YAML.load_file("config/route_tracker.yml")
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
      def check_route_level(request)
        binary_level = LEVEL_CONFIG[request.method][request.path] rescue nil
        return if binary_level.blank?
        binary_level = 2**binary_level
        #return if already visited
        return if self.route_visited?(request.path, request.method)
        current_level = self[self.class.track_level]
        return if current_level.nil?
        new_level = current_level | binary_level
        update_attribute(self.class.track_level, new_level)
      end
      def route_visited?(route, method = "GET" )
        current_level = self[self.class.track_level] rescue 0
        binary_level = LEVEL_CONFIG[method][route] rescue nil
        return false if binary_level.blank?
        #binary level is already activated
        return true if 2**binary_level & current_level > 0
        return false
      end
      def activate_route_binary(num)
        return unless (Integer(num) rescue -1) >= 0
        current_level = self[self.class.track_level]
        new_level = current_level | num
        update_attribute(self.class.track_level, new_level)
      end
    end
  end
end

ActiveRecord::Base.send :include, RouteTracker::RouteTrackeable
