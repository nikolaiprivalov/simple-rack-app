class StaticServer
  STATIC_FILE_EXTENTIONS = /[.](css|js|jpg)$/.freeze

  def initialize(app, static_dir: "#{Dir.pwd}/public")
    @app = app
    @static_dir = static_dir
  end

  def call(env)
    serve_file(env['PATH_INFO']) || @app.call(env)
  end

  private

  def serve_file(path)
    file = Pathname.new(@static_dir + path).cleanpath

    return [200, {}, [file.read]] if file.file? && file.readable?
    return [404, {}, []] if file.extname =~ STATIC_FILE_EXTENTIONS

    nil
  end
end
