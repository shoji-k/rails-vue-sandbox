require 'net/http'

class Api::V1::HttpbinController < Api::V1::ApplicationController
  skip_before_action :authenticate_user

  def index
    uri = URI.parse('https://httpbin.org/ip')
    response = Net::HTTP.get_response(uri)
    ip = JSON.parse(response.body)['origin']
    render json: { ip: }
  end
end
