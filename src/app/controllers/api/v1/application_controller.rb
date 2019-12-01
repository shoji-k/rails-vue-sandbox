class Api::V1::ApplicationController < ActionController::API
  def render_error(model)
    errors = []
    errors << model.errors
    status = if model.invalid?
               :unprocessable_entity
             else
               :bad_request
             end
    render json: { errors: errors }, status: status
  end
end
