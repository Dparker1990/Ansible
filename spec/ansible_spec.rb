require 'ansible'

describe Ansible do
  let(:config_path) { 'lib/generators/ansible/templates/ansible.yml' }

  describe '.load_config' do
    context 'with an available config file' do
      it 'loads the configuration file' do
        Ansible.load_config(config_path).should be_true
        Ansible.config.should eq({ "development" => { "thing" => 'yeah' } })
      end
    end
  end

  describe '.reset_config' do
    before { Ansible.load_config config_path }

    it 'sets the config to an empty hash' do
      Ansible.config.should_not be_empty
      Ansible.reset_config
      Ansible.config.should be_empty
    end
  end
end
