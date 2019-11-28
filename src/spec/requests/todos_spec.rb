require 'rails_helper'

RSpec.describe "Todos", type: :request do
  describe "GET /api/v1/todos" do
    it "works! (now write some real specs)" do
      get api_v1_todos_path
      expect(response).to have_http_status(200)
    end
  end
end
