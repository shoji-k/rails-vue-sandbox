require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /api/v1/users' do
    let!(:user) { FactoryBot.create(:user) }

    it 'can access and get data' do
      get api_v1_users_path
      assert_response_schema_confirm
      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json['data'].count).to eq(1)
    end
  end
end
