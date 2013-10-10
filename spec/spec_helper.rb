require "select_options"


ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3", 
  :database => ":memory:")

load File.dirname(__FILE__) + '/support/schema.rb'
load File.dirname(__FILE__) + '/support/models.rb'
load File.dirname(__FILE__) + '/support/data.rb'
