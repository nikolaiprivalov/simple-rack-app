require 'logger'

class RequestLogger
  def initialize(app, logger: ::Logger.new('middleware.log'))
    @app = app
    @logger = logger
  end

  def call(env)
    @app.call(env).tap do |status, _headers, _body|
      log(env['REQUEST_METHOD'], env['PATH_INFO'], status)
    end
  end

  private

  def log(method, path, status)
    @logger.info(['->', method, path].join(' | '))
    @logger.info(['<-', status, path].join(' | '))
  end
end
