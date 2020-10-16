class ErrorCatcher
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    return request_static(env, '/404.html') if status == 404

    [status, headers, body]
  rescue StandardError
    request_static(env, '/500.html')
  end

  private

  def request_static(env, path)
    env['PATH_INFO'] = path
    @app.call(env)
  end
end
