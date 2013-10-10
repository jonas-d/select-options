require "spec_helper"

describe ActiveRecord::Base do

  describe "Links to model via 'has_one :through' association" do

    before :all do
      @separator = "-"
    end

    context "link to model of single type" do

      before :each do
        @b = Bucket.create()
        @m = Marble.create()
      end

      it "updates association" do
        attributes = { "id" => @m.id, "bucket" => @b.class.to_s + @separator + @b.id.to_s }
        @m.update_attributes(attributes).should == true
        @m.bucket.should == @b
        BucketMarble.where(:bucket_id => @b.id, :marble_id => @m.id).count.should == 1
      end

      it "removes association" do
        @m.bucket = @b
        @m.save
        @m.bucket.should == @b
        @m.bucket = nil
        @m.save
        @m.bucket.should == nil
      end

    end


    context "link to STI models (polymorphic association)" do

      before :each do
        @u = User.create()
        @e = Expert.create()
        @a = Admin.create()
      end

      it "updates association" do
        attributes = { "id" => @u.id, "group" => @e.class.to_s + @separator + @e.id.to_s }
        @u.update_attributes(attributes).should == true
        @u.group.should == @e
        GroupUser.where(:group_id => @e.id, :user_id => @u.id).count.should == 1
      end

      it "removes association" do
        @u.group = @a
        @u.save
        @u.group.should == @a
        @u.group = nil
        @u.save
        @u.group.should == nil
      end

    end


    context "link to model of different types (polymorphic association)" do

      before :each do
        @u = User.create()
        @b = Bucket.create()
        @c = Certificate.create()
      end

      it "updates association" do
        attributes = { "id" => @u.id, "certificate" => @c.class.to_s + @separator + @c.id.to_s }
        @u.update_attributes(attributes).should == true
        @u.certificate.should == @c
        EntityCertificate.where(:certificate_id => @c.id, :entity_id => @u.id).count.should == 1
      end

      it "removes association" do
        @c.entity = @b
        @c.save
        @c.entity.should == @b
        @c.entity = nil
        @c.save
        @c.entity.should == nil
      end

    end

  end

end
