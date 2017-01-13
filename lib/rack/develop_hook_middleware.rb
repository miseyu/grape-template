module Rack
  class DevelopHookMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      env['HTTP_HOST'] = ENV['PROXY_HOST'] if ENV['PROXY_HOST'].present?
      @app.call(env)
    end

  end
end
