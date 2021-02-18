require 'net/http'
require 'uri'

class SampleJob < ApplicationJob
  queue_as :default
  after_perform :after_perform

  def perform(*_args)
    uri = URI.parse('https://httpbin.org/ip')
    response = Net::HTTP.get_response(uri)
    response.code
    # p response.body
  end

  private

  def after_perform
    # p 'finished'
  end
end
