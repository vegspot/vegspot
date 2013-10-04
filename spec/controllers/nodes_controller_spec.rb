require 'spec_helper'

describe NodesController do
  #include Devise::TestHelpers

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it "renders index template" do
      get :index
      expect(response).to render_template('index')
    end

    it "loads most popular nodes for this week"
  end

  describe "GET #new" do
    context "user is admin" do
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = User.where(is_admin: true).first
        sign_in @user
      end

      it "responds successfully with an HTTP 200 status code" do
        get :new
        expect(response).to be_success
        expect(response.status).to eq 200
      end
    end

    context "user is regular" do
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = User.where(is_admin: nil).first
        sign_in @user
      end

      it "responds unsuccessfully with an HTTP 501 status code" do
        get :new
        expect(response).to be_error
        expect(response.status).to eq 501
      end
    end
  end

end