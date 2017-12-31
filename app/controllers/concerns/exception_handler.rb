module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern



  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end

  included do
    # Define custom handler
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
    rescue_from ExceptionHandler::ExpiredSignature, with: :four_ninety_eight

    rescue_from ActiveRecord::RecordNotFound do |e|
    json_response({ message: e.message}, :not_found)
  end
 end

  private

  #json response with messaage; Status code 422 - unprocessable entity

  def four_twenty_two(e)
    json_response({ messaage: e.message }, :unprocessable_entity)
  end
  #json response with messaage; Status code 498 - Invalid Token

  def four_ninety_eight(e)
    json_response({ messaage: e.message }, :invalid_token)
  end

  #json response with message; status code 401 - Unauthorized

  def unauthorized_request(e)
    json_response({ message: e.message }, :unauthorized)
  end
end