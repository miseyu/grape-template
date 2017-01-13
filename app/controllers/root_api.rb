class RootAPI < Grape::API
  mount GeneralAPI

  helpers APIHelpers

  route :any, '*path' do
    Rails.logger.warn "404 not found. cause. path = #{request.path}. user_agent = #{request.env['HTTP_USER_AGENT']}"
    not_found!
  end

end
