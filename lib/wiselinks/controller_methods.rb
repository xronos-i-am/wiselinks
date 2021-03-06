module Wiselinks
  module ControllerMethods    
    
    def self.included(base)      
      base.helper_method :wiselinks_title      

      base.before_filter :set_wiselinks_url
    end

  protected

    def wiselinks_layout
      'wiselinks'
    end

    def wiselinks_title(value)
      if self.request.wiselinks? && value.present?
        Wiselinks.log("title: #{value}")        
        self.response.headers['X-Wiselinks-Title'] = URI.encode(value)
      end
    end

    def set_wiselinks_url      
      if self.request.wiselinks?
        self.response.headers['X-Wiselinks-Url'] = request.base_url + request.env['REQUEST_URI'].gsub( /[\&\?]_=\d+/, '' )
      end
    end
  end
end