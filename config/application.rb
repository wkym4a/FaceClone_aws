require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)


module FaceClone
  class Application < Rails::Application
    config.load_defaults 5.1

    #使用する「時間」を東京のものに
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
  end
end
