require "select_options"
require "database_cleaner"
require "xmlsimple"

# create in memory test db
ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3", 
  :database => ":memory:")

load File.dirname(__FILE__) + '/support/schema.rb'
load File.dirname(__FILE__) + '/support/models.rb'


RSpec.configure do |config|

  # ActionView::Helpers::FormOptionsHelper is required for options_for_select method
  # in select_options/app/helpers/select_option_helpers.rb
  config.include ActionView::Helpers

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
