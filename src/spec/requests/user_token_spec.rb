require 'rails_helper'

RSpec.describe 'User Token', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe 'GET /api/v1/sign_in' do
    context 'An valid user' do
      let(:params) {
        {
          email: user.email,
          password: user.password
        }
      }

      it 'can login' do
        post api_v1_sign_in_path, params: { auth: params }
        assert_response_schema_confirm 201
        expect(response).to have_http_status(:success)

        data = response.parsed_body
        expect(data['jwt']).not_to be ''
      end
    end

    context 'A non existing user' do
      let(:params) {
        {
          email: 'dummy@sample.com',
          password: 'password'
        }
      }

      it 'can not login' do
        post api_v1_sign_in_path, params: { auth: params }
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'An valid user with the wrong password' do
      let(:params) {
        {
          email: user.email,
          password: 'wrong password'
        }
      }

      it 'can not login' do
        post api_v1_sign_in_path, params: { auth: params }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
