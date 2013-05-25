require 'ansible/sse'

describe Ansible::SSE do
  let(:io) { stub(write: true) }
  let(:sse) { Ansible::SSE.new(io) }

  describe '#write' do
    context 'with an event specified' do
      let(:event) { 'message' }

      it 'sends data accross the pipe in the correct format' do
        io.should_receive(:write).with("event: message\n")
        io.should_receive(:write).with("data: hello\n\n")
        sse.write(:message, 'hello')
      end
    end
  end

  describe '#close' do
    it 'closes the IO connection' do
      io.should_receive :close
      sse.close
    end
  end
end
