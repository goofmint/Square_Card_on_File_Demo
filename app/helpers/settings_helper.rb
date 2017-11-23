module SettingsHelper
  def load_config
    return @config if @config
    @config = YAML.load_file(Rails.root.join('config', 'square.yml'))[Rails.env]
    return @config
  end
end
