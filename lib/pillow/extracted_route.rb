module Pillow
  class ExtractedRoute
    @@extracted_routes = []
    METHOD_PREFIX      = '_pillow'
    attr_accessor :name, :requirements, :segments, :route
    attr_reader   :pillow_method
    def initialize(name, requirements = {}, segments = '')
      @name         = name
      @requirements = requirements
      @segments     = segments
      @pillow_method= name + METHOD_PREFIX
      @route        = Route.new
      @@extracted_routes.push(self)
    end
  
    def self.extracted_routes
      @@extracted_routes
    end
  end  
end