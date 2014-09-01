# Recursively require all files in a directory relative to the application root
def require_all(dir)
  app_root = Dir[File.expand_path('../../..', __FILE__)]
  Dir[File.join(app_root, dir, '**/*.rb')].each { |f| require f }
end
