require "rails"
require "active_record"
require "action_view"

require "select_options/version"
require "select_options/active_record_extension"
require "select_options/app/helpers/select_options_helper"


module SelectOptions

  class Railtie < Rails::Railtie
    initializer "select_options_init" do
      # include select options extension into ActiveRecord::Base class
      ActiveSupport.on_load(:active_record) do
        # ActiveRecord::Base.send(:include, SelectOptions::ActiveRecordExtension)
        include SelectOptions::ActiveRecordExtension
        ActiveRecord::Base.replace_update_attributes_method
      end
      # include helpers to ActionView::Base class
      ActiveSupport.on_load(:action_view) do
        include SelectOptionsHelper
      end
    end
  end

end
