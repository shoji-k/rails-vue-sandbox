class Api::V1::ApplicationController < ActionController::API
  include ActionPolicy::Controller
  include Knock::Authenticable
  before_action :authenticate_user
  authorize :user, through: :current_user

  def render_error(model)
    errors = []
    errors << model.errors
    status = if model.invalid?
               :unprocessable_entity
             else
               :bad_request
             end
    render json: { errors: }, status:
  end
end
