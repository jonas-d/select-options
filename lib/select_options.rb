require "select_options/version"

require "active_record"
require "action_view"
require "database_cleaner"
require "select_options/data_model_extension"
require "select_options/app/helpers/select_options_helper"

module SelectOptions
  # Your code goes here...
end

ActionView::Base.send :include, SelectOptionsHelper
