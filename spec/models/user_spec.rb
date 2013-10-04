require 'spec_helper'
require "cancan/matchers"

describe User do
  it "has a valid factory" do
    FactoryGirl.build(:user).should be_valid
  end

  it "is invalid with wrong email" do
    FactoryGirl.build(:user, email: 'regular').should_not be_valid
    FactoryGirl.build(:user, email: 'regular@vegspot').should_not be_valid
  end

  describe "abilities" do
    subject(:ability){ Ability.new(user) }
    let(:user){ nil }

    context "when is admin" do
      let(:user){ FactoryGirl.build(:user, :admin) }

      it { should be_able_to(:create, Node.new) }
      it { should be_able_to(:edit, Node.first) }
    end

    context "when is a regular user" do
      let(:user){ FactoryGirl.build(:user) }

      it "is able to create a new node" do
        node = Node.new
        should be_able_to(:create, Node.new)
      end

      it "is not able to edit existing node" do
        @node = FactoryGirl.build(:node)
        should_not be_able_to(:create, @node) 
      end
    end
  end

  describe "#is_admin?" do
    it "returns true if user is admin" do
      FactoryGirl.build(:user, :admin).is_admin?.should eq(true)
    end

    it "returns false if user is not an admin" do
      FactoryGirl.build(:user).is_admin?.should eq(false)
    end
  end
end