class ApplicationController < ActionController::API
  include ExceptionHandler
  include ActionController::MimeResponds
  respond_to :json
end
