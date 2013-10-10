require "spec_helper"
require "xmlsimple"

include SelectOptionsHelper

describe SelectOptionsHelper do

  describe "Providing select options entries" do

    it "contains all passed model instances with 'type-id' identifiers" do
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