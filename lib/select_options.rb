require "rails"
require "active_record"
require "action_view"

require "select_options/version"
require "select_options/data_model_extension"
require "select_options/app/helpers/select_options_helper"


module SelectOptions

  class Railtie < Rails::Railtie
    initializer "select_options_init" do

    end
  end

end


ActionView::Base.send :include, SelectOptionsHelper
