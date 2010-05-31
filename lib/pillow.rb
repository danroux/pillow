# HeadElements
require 'pillow/core_ext'
require 'pillow/route'
require 'pillow/extracted_route'
require 'pillow/view_helpers'
module Pillow
  def self.extract_app_routes
    app_routes = ActionController::Routing::Routes.routes
    app_routes.each do |route|
      name = ActionController::Routing::Routes.named_routes.routes.index(route).to_s
      exr  = ExtractedRoute.new(name)
      exr.requirements = route.requirements
      exr.segments     = route.segments.join("")
    end
  end
  
  def self.enable_view_helpers
    ActionView::Base.send :include, ViewHelpers
    Route.send(:include, ActionView::Helpers::TagHelper)    
  end

  def self.enable
    extract_app_routes    
    enable_view_helpers
  end  
end
require "#{RAILS_ROOT}/config/pillow.rb"