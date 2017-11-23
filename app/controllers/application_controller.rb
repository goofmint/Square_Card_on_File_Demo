require 'square_connect'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  def load_config
    return @config if @config
    @config = YAML.load_file(Rails.root.join('config', 'square.yml'))[Rails.env]
    return @config
  end
  
  def square
    return @square if @square
    @square = SquareConnect.configure do |config|
      config.access_token = load_config['access_token']
    end
    @square
  end
end
