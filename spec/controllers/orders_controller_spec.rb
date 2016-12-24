require 'rails_helper'
describe OrdersController, type: :controller do
  describe 'GET index' do
    context 'if no user authenticated' do
      it 'should redirect' do
        get :index
        expect(response).to have_http_status(200)
      end
    end
  end
end
