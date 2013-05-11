require 'ansible'

describe Ansible do
  let(:config_path) { 'lib/generators/ansible/templates/ansible.yml' }
  let(:environment) { 'test' }

  describe '.load_config' do
    context 'with an available config file' do
      it 'loads the configuration file' do
        Ansible.load_config config_path, environment
        Ansible.config.should eq({ thing: 'yeah' })
      end
    end

    context 'without a config file' do
      let(:config_path) { '' }

      it 'raises an ArguementError' do
        expect do
          Ansible.load_config(config_path, environment)
        end.to raise_error Errno::ENOENT
      end
    end
  end

  describe '.reset_config' do
    before { Ansible.load_config config_path, environment }

    it 'sets the config to an empty hash' do
      Ansible.config.should_not be_empty
      Ansible.reset_config
      Ansible.config.should be_empty
    end
  end
end
