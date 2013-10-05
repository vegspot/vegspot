require 'spec_helper'
require "cancan/matchers"

describe User do
  let(:user) { FactoryGirl.build(:user) }

  it "has a valid factory" do
    expect(user).to be_valid
  end

  it "is invalid with wrong email" do
    user.email = 'regular'
    expect(user).to be_invalid

    user.email = 'regular@vegspot'
    expect(user).to be_invalid
  end

  describe "abilities" do
    subject(:ability) { Ability.new(user) }
    let(:user) { nil }

    context "when is admin" do
      let(:user){ FactoryGirl.build(:user, :admin) }

      it { should be_able_to(:create, Node.new) }
      it { should be_able_to(:edit, Node.first) }
      it { should be_able_to(:update, Node.first) }
    end

    context "when is a regular user" do
      let(:user){ FactoryGirl.create(:user) }
      let(:node){ FactoryGirl.build(:node) }

      it { should be_able_to(:create, node) }
      it { should_not be_able_to(:update, node) }
      it { should_not be_able_to(:edit, node) }
    end
  end
end