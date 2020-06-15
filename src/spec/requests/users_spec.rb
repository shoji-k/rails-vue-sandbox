require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:login_user) { FactoryBot.create(:user) }
  let!(:user) { FactoryBot.create(:user) }

  describe 'GET /api/v1/users' do
    it 'can access and get data' do
      get api_v1_users_path, headers: authenticated_header(login_user)
      assert_schema_conform
      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)
      expect(json['data'].count).to eq(2)
    end
  end

  describe 'GET /api/v1/users/:id' do
    context 'exception' do
      let(:dummy_user_id) do
        9_999_999
      end

      it 'throws not found error' do
        expect {
          get api_v1_user_path(dummy_user_id.to_s), headers: authenticated_header(login_user)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'success' do
      it 'gets data' do
        get api_v1_user_path(user), headers: authenticated_header(login_user)
        assert_schema_conform
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
          password_confirmation: 'password',
          role: :system
        }
      }

      it 'creates a user' do
        post api_v1_users_path, params: { user: params }
        assert_schema_conform
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
        assert_schema_conform
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /api/v1/user/:id' do
    context 'success' do
      let(:params) {
        {
          name: 'sample name',
          email: 'sample@sample.com',
          password: 'password',
          password_confirmation: 'password'
        }
      }

      it 'updates the user' do
        put api_v1_user_path(user), headers: authenticated_header(login_user), params: { user: params }
        assert_schema_conform
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

      it 'get errors with wrong confirm password' do
        put api_v1_user_path(user), headers: authenticated_header(login_user), params: { user: params }
        assert_schema_conform
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /api/v1/user/:id' do
    context 'success' do
      it 'deletes the user' do
        delete api_v1_user_path(user), headers: authenticated_header(login_user)
        assert_schema_conform
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
