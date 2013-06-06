require 'rspec-spies'

ActiveRecord::Base.establish_connection :adapter => :postgresql,
    :adapter => 'postgresql',
    :database => 'ansible_test',
    :pool => 5,
    :timeout => 5000,
    :host => 'localhost'

RSpec.configure do |config|
  config.before do
    Pathname.new(__FILE__).expand_path.join('../').to_s
  end
end
