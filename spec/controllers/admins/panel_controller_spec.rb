require 'rails_helper'

describe Admins::PanelController do
  include Devise::Test::ControllerHelpers

  describe 'GET #edit_driver_photo' do
    it 'should redirect to sessions#new if admin not sign in' do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      @driver = create(:driver)
      get :edit_driver_photo, id: @driver.id
      expect(response).to redirect_to('/admin')
    end
  end

  describe 'POST #update_driver_photo' do
    it 'should redirect to sessions#new if admin not sign in' do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      @driver = create(:driver)
      post :update_driver_photo, id: @driver.id
      expect(response).to redirect_to('/admin')
    end
  end
end
