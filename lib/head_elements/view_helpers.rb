module HeadElements
  module ViewHelpers        
    def self.included(base)    
      ExtractedRoute.extracted_routes.each do |r|        
        m = r.name + ExtractedRoute::METHOD_PREFIX
        return if ActionView::Base.instance_methods.include_method? :"#{m}"
        define_method m do 
          r.route
        end
      end
    end 
              
    def meta_help      
      route = find_matching_route
      if route
        eval(route.meta_method)
      end
    end
  
    def find_matching_route
      action, controller = params[:action], params[:controller]      
      ExtractedRoute.extracted_routes.detect{ |r| r.requirements[:controller] == controller && r.requirements[:action] == action }
    end      
  end
end