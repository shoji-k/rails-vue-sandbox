require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { FactoryBot.create(:user) }

  describe 'GET /api/v1/users' do
    it 'can access and get data' do
      get api_v1_users_path
      assert_response_schema_confirm
      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json['data'].count).to eq(1)
    end
  end

  describe 'GET /api/v1/users/:id' do
    context 'exception' do
      let(:dummy_user_id) do
        9_999_999
      end

      it 'throws not found error' do
        expect {
          get(api_v1_user_path(dummy_user_id.to_s))
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'success' do
      it 'gets data' do
        get api_v1_user_path(user)
        assert_response_schema_confirm
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST /api/v1/user' do
    context 'success' do
      let(:params) {
        {
          name: 'sample name',
          email: 'sample@sample.com',
          password: 'password',
          password_confirmation: 'password'
        }
      }

      it 'creates a user' do
        post api_v1_users_path, params: { user: params }
        assert_response_schema_confirm
        expect(response).to have_http_status(:success)
      end
    end

    context 'failure' do
      let(:params) {
        {
          name: 'sample name',
          email: 'sample@sample.com',
          password: 'password',
          password_confirmation: 'wrong password'
        }
      }

      it 'gets errors with the wrong password confirmation' do
        post api_v1_users_path, params: { user: params }
        assert_response_schema_confirm
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
