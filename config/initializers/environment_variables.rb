module EnvironmentVariablesExample
  class Application < Rails::Application
    config.before_configuration do
      aws_file = Rails.root.join("config", 'aws.yml').to_s
      if File.exists?(aws_file)
        YAML.load_file(aws_file)[Rails.env].each do |key, value|
          ENV[key.to_s] = value
        end
      end
    end
  end
end