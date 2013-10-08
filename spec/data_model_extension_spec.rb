require "spec_helper"

describe ActiveRecord::Base do

  describe "Links to model via 'has_one / belongs_to :through' association" do


    context "single type association to model" do

      before :each do
        Bucket.create()
        Bucket.create()
        Marble.create()
        @m = Marble.all.first
        @b = Bucket.all.first
      end

      it "updates association" do
        attributes = { "id" => @m.id, "bucket" => @b.class.to_s + "=" + @b.id.to_s }
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


    context "polymoprhic association to model (pure STI)" do

      before :each do
        @u = User.create()
        @a = Admin.create()
        @e = Expert.create()
      end

      it "updates association" do
        attributes = { "id" => @u.id, "group" => @a.class.to_s + "=" + @a.id.to_s }
        @u.update_attributes(attributes).should == true
        @u.group.should == @a
        attributes = { "id" => @u.id, "group" => @e.class.to_s + "=" + @e.id.to_s }
        @u.update_attributes(attributes).should == true
        @u.group.should == @e
        GroupUser.where(:group_id => @e.id, :user_id => @u.id).count.should == 1
      end

      it "removes association" do
        @u.group = @e
        @u.save
        @u.group = nil
        @u.save
        @u.group.should == nil
      end

    end


    context "polymorphic association to model (arbitrary types)" do

      it "updates association attribute"
      it "removes association attribute"

    end

  end

end
