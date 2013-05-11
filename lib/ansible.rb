require 'ansible/version'

module Ansible

  class << self
    attr_reader :config

    def load_config path
      @config = YAML.load_file path
    end

    def reset_config
      @config = {}
    end
  end
end
