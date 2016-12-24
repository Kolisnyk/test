require 'rails_helper'

RSpec.describe DispatchersController, type: :controller do

  describe "GET #profile" do
    it "returns http status 302" do
      get :profile
      expect(response).to have_http_status(302)
    end
  end

end
