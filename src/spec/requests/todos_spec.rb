require 'rails_helper'

RSpec.describe 'Todos', type: :request do
  describe 'GET /api/v1/todos' do
    context 'without data' do
      it 'can access and get empty' do
        get api_v1_todos_path
        expect(response).to have_http_status(200)

        json = JSON.parse(response.body)
        expect(json['data'].count).to eq(0)
      end
    end

    context 'with data' do
      let!(:todo) { FactoryBot.create(:todo) }

      it 'can access and get data' do
        get api_v1_todos_path
        expect(response).to have_http_status(200)

        json = JSON.parse(response.body)
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
end
