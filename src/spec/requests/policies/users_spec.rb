require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let!(:login_user) { FactoryBot.create(:user) }

  describe 'authorization' do
    describe 'GET /api/v1/users' do
      it 'is set' do
        expect {
          get api_v1_users_path, headers: authenticated_header(login_user)
        }.to be_authorized_to(:index?, login_user).with(UserPolicy)
      end
    end
  end
end
