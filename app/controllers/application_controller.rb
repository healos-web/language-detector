class ApplicationController < Sinatra::Base; end

class ApplicationControllerBase < Sinatra::Base  
  configure do
    set :views, 'app/views'
  end
  
  def self.inherited(subclass)
    super

    ApplicationController.use subclass
  end
end
