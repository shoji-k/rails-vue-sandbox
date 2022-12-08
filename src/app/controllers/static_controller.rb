require 'rails/application_controller'

class StaticController < Rails::ApplicationController
  def index
    render file: Rails.public_path.join('index.html'), layout: false
  end
end
