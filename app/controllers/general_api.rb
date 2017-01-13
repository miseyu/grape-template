# == general api
#
class GeneralAPI < Grape::API
  format :json
  default_format :json
  content_type :json, "application/json; charset=UTF-8"

  include ErrorHandler

  helpers APIHelpers
  helpers APISharedParams

  before do
    authenticate!
  end

  after do
  end

  # include API::Hogefuga

end
