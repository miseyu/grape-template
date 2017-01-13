module APIHelpers

  ACCESS_KEY_HEADER = 'X-Http-Access-Key'
  SECRET_KEY_HEADER = 'X-Http-Secret-Key'

  def authenticate!
    result = AccessKey.find_by_access_key(access_key)
    unauthorized! if result.blank?
    unauthorized! unless result.authenticate(secret_key)
  end

  def subdomain
    match = request.host.match(/(.+?).#{Settings.host_domain}/)
    return match[1] if match.present?
  end

  def access_key
    headers[ACCESS_KEY_HEADER]
  end

  def secret_key
    headers[SECRET_KEY_HEADER]
  end

  def paginate(object)
    return object if params[:page].blank?
    page = params[:page]
    per_page = params[:per_page]
    result = object.try(:page, page).try(:per, per_page)
    return object unless result
    result
  end

  def present_with_paging(data , with: , options: {})
    total_count = data.count
    items = paginate(data)
    items = yield(items) if block_given?
    options[:with] = with
    items = with.represent items, options
    { status: :success, data: { items: items['items'], total_count: total_count } }
  end

  def present_without_paging(data, with:, options: {})
    options[:with] = with
    result = with.represent data, options
    { status: :success, data: result  }
  end

  def logger
    Rails.logger
  end

  def forbidden!
    render_api_error!('403 Forbidden', 403)
  end

  def bad_request!(attribute = '')
    message = ["400 (Bad request)"]
    message << "\"" + attribute.to_s + "\" not given"
    render_api_error!(message.join(' '), 400)
  end

  def not_found!(resource = nil)
    message = ["404"]
    message << resource if resource
    message << "Not Found"
    render_api_error!(message.join(' '), 404)
  end

  def unauthorized!(message = '401 Unauthorized Error')
    render_api_error! message, 401
  end

  def password_expired!(message = '401 Password Expired Error')
    render_api_error! message, 401, reason_code: :password_expired
  end

  def not_allowed!
    render_api_error!('Method Not Allowed', 405)
  end

  def validate_error!(message)
    render_api_error!(message, 400)
  end

  def render_api_error!(message, status, reason_code: nil)
    messages = []
    messages << message
    logger.error "api error! status = #{status}. cause. #{messages.flatten}"
    result = { status: :error,  messages: messages.flatten, data: nil }
    result[:error_code] = reason_code if reason_code.present?
    error!(result, status)
  end

  def success
    { status: :success, data: nil }
  end

end
