require 'rails_helper'

RSpec.describe 'Todos', type: :request do
  let!(:login_user) { FactoryBot.create(:user) }

  describe 'GET /api/v1/todos' do
    context 'without data' do
      it 'can access and get empty' do
        get api_v1_todos_path, headers: authenticated_header(login_user)
        assert_schema_conform 200
        expect(response).to have_http_status(:ok)

        json = response.parsed_body
        expect(json['data'].count).to eq(0)
      end
    end

    context 'with data' do
      let!(:todo) { FactoryBot.create(:todo) }

      it 'can access and get data' do
        get api_v1_todos_path, headers: authenticated_header(login_user)
        assert_schema_conform 200
        expect(response).to have_http_status(:ok)

        json = response.parsed_body
        expect(json['data'].count).to eq(1)

        first = json['data'].first
        expect(first['id']).to eq todo.id.to_s
        expect(first['type']).to eq todo.class.name.downcase

        attributes = first['attributes']
        expect(attributes['title']).to eq todo.title
        expect(attributes['detail']).to eq todo.detail
        expect(attributes['done']).to eq todo.done
      end
    end
  end

  describe 'GET /api/v1/todos/:id' do
    context 'exception' do
      let(:dummy_todo_id) do
        9_999_999
      end

      it 'throw not found error' do
        expect {
          get api_v1_todo_path(dummy_todo_id.to_s), headers: authenticated_header(login_user)
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'success' do
      let!(:todo) { FactoryBot.create(:todo) }

      it 'gets data' do
        get api_v1_todo_path(todo), headers: authenticated_header(login_user)
        assert_schema_conform 200
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'POST /api/v1/todo' do
    context 'success' do
      let(:params) {
        {
          title: 'sample title',
          detail: 'sample detail',
          done: false
        }
      }

      it 'creates a todo' do
        post api_v1_todos_path, headers: authenticated_header(login_user), params: { todo: params }
        assert_schema_conform 201
        expect(response).to have_http_status(:success)
      end
    end

    context 'failure' do
      let(:params) {
        {
          detail: 'sample detail',
          done: false
        }
      }

      it 'gets errors without a mandatory field' do
        post api_v1_todos_path, headers: authenticated_header(login_user), params: { todo: params }
        assert_schema_conform 422
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /api/v1/todo/:id' do
    let!(:todo) { FactoryBot.create(:todo) }

    context 'success' do
      let(:params) {
        {
          title: 'title changed',
          detail: 'detail changed',
          done: true
        }
      }

      it 'updates the todo' do
        put api_v1_todo_path(todo), headers: authenticated_header(login_user), params: { todo: params }
        assert_schema_conform 200
        expect(response).to have_http_status(:success)
      end
    end

    context 'failure' do
      let(:params) {
        {
          title: ''
        }
      }

      it 'with wrong params' do
        put api_v1_todo_path(todo), headers: authenticated_header(login_user), params: { todo: params }
        assert_schema_conform 422
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /api/v1/todo/:id' do
    let!(:todo) { FactoryBot.create(:todo) }

    context 'success' do
      it 'deletes the todo' do
        delete api_v1_todo_path(todo), headers: authenticated_header(login_user)
        assert_schema_conform(204)
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
