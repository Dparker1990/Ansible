require 'ansible/version'

module Ansible

  class << self

    def load_config path, environment
      yaml = YAML.load_file(path)[environment]
      yaml.each { |key, value| config[key.to_sym] = value }
    end

    def reset_config
      @config = {}
    end

    def config
      @config ||= {}
    end
  end
end
