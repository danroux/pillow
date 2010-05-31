# HeadElements
require 'pillow/core_ext'
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
  
  def self.enable
    extract_app_routes    
    enable_view_helpers
  end
  
  def self.enable_view_helpers
    ActionView::Base.send :include, ViewHelpers
    Route.send(:include, ActionView::Helpers::TagHelper)    
  end
  
  class Route
    attr_accessor :title, :metas
    def initialize(title = 'Change', metas = {})
      raise ArgumentError, ' title has to be a String.' if !title.instance_of? String
      raise ArgumentError, ' metas has to be a Hash.'   if !metas.instance_of? Hash            
      @title = title
      @metas = metas
    end
    
    def to_s
      text_for_head = ''
      text_for_head << content_tag(:title, title) + "\n"
      @metas.each_pair do |key, value|
        text_for_head << tag(:meta, { :name => key, :content => value }, false)
      end
      text_for_head
    end    
  end
  
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
ApplicationController.send :include, Pillow
