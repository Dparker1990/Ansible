module Ansible
  class ConstantResolver
    def initialize(name)
      @name = name
    end

    def lookup_constant
      name.constantize
    end

    private

    def name
      @name.to_s
    end
  end
end
