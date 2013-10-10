require "spec_helper"

include SelectOptionsHelper

describe SelectOptionsHelper do

  describe "Providing select options entries" do

    it "contains all passed model instances with 'type-id' identifiers" do
      u = User.create(:name => "Ernie")
      b = Bucket.create(:caption => "round bucket")
      c = Certificate.create()
      puts through_association_options_for_select(User.all, :name)
    end

  end

end