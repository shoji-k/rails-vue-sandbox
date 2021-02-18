module RequestHelper
  def authenticated_header(user)
    token = Knock::AuthToken.new({ payload: user.to_token_payload }).token
    { Authorization: "Bearer #{token}" }
  end
end

RSpec.configure do |c|
  c.include RequestHelper, type: :request
end
