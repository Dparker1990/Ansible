require 'rspec-spies'
require 'fixtures/fake_rails_app'
require 'fixtures/controllers'

ActiveRecord::Base.establish_connection :adapter => :postgresql,
    :adapter => 'postgresql',
    :database => 'ansible_test',
    :pool => 5,
    :timeout => 5000,
    :host => 'localhost'
