require "rails"
require "active_record"
require "action_view"

require "select_options/version"
require "select_options/active_record_extension"
require "select_options/app/helpers/select_options_helper"


module SelectOptions

  class Railtie < Rails::Railtie

    initializer "select_options_init" do
      puts "++++++++++++++++++++ init 1"
      # include select options extension into ActiveRecord::Base class
      ActiveSupport.on_load(:active_record) do
        # ActiveRecord::Base.send(:include, SelectOptions::ActiveRecordExtension)
        include SelectOptions::ActiveRecordExtension
        ActiveRecord::Base.replace_update_attributes_method
      end
      puts "++++++++++++++++++++ init 2"
      # include helpers to ActionView::Base class
      ActiveSupport.on_load(:action_view) do
        include SelectOptions::Helper
        puts "++++++++++++++++++++ include"
      end
    end

  end

end
