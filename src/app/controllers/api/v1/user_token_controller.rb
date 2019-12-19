class Api::V1::UserTokenController < Knock::AuthTokenController
  skip_before_action :verify_authenticity_token # unless this, 422 happens
end
