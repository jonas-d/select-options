require "spec_helper"

include SelectOptions::Helper

describe SelectOptions::Helper do

  describe "Providing select options entries" do

    # this test could be improved by adding a controller and view to the gem test framework
    # (I tried and decided to do it without controller and view)
    it "contains all model instances with identifiers of the form 'type-id'" do
      separator = "-"
      u = User.create(:name => "Ernie")
      b = Bucket.create(:name => "round bucket")
      c = Certificate.create()
      xml = "<root>" + through_association_options_for_select(User.all + Bucket.all, :name) + "</root>"
      options = XmlSimple.xml_in(xml)
      options["option"][0]["value"].should == u.class.to_s + separator + u.id.to_s
      options["option"][0]["content"].should == u.name
      options["option"][1]["value"].should == b.class.to_s + separator + b.id.to_s
      options["option"][1]["content"].should == b.name
    end

  end

end