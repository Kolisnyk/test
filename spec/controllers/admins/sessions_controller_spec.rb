require 'rails_helper'

describe Admins::SessionsController do
  include Devise::Test::ControllerHelpers

  describe 'GET #new' do
    it "opens a login page for admins" do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      get :new
      assert_response 200
    end
  end
end
