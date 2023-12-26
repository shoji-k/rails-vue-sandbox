require 'rails_helper'

RSpec.describe 'Api::V1::Users' do
  let!(:login_user) { FactoryBot.create(:user) }
  let!(:user) { FactoryBot.create(:user) }

  describe 'authorization' do
    describe 'GET /api/v1/users' do
      it 'is set' do
        expect {
          get api_v1_users_path, headers: authenticated_header(login_user)
        }.to be_authorized_to(:index?, User).with(UserPolicy)
      end
    end

    describe 'GET /api/v1/users/:id' do
      it 'is set' do
        expect {
          get api_v1_user_path(user), headers: authenticated_header(login_user)
        }.to be_authorized_to(:show?, an_instance_of(User)).with(UserPolicy)
      end
    end

    # rubocop:disable RSpec/EmptyExampleGroup
    describe 'POST /api/v1/user' do
      # everyone can use this
    end
    # rubocop:enable RSpec/EmptyExampleGroup

    describe 'PUT /api/v1/user/:id' do
      let(:params) {
        {
          name: 'sample name',
          email: 'sample@sample.com',
          password: 'password',
          password_confirmation: 'password'
        }
      }

      it 'is set' do
        expect {
          put api_v1_user_path(user), headers: authenticated_header(login_user), params: { user: params }
        }.to be_authorized_to(:edit?, an_instance_of(User)).with(UserPolicy)
      end
    end

    describe 'DELETE /api/v1/user/:id' do
      it 'is set' do
        expect {
          delete api_v1_user_path(user), headers: authenticated_header(login_user)
        }.to be_authorized_to(:edit?, an_instance_of(User)).with(UserPolicy)
      end
    end
  end
end
