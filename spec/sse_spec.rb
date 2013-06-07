require 'ansible/sse'

describe Ansible::SSE do
  let(:io) { stub(write: true) }
  let(:sse) { Ansible::SSE.new(io) }

  describe '#write' do
    context 'with an event specified' do
      it 'sends data accross the pipe in the correct format' do
        sse.write(:message, hello: 'hello')
        io.should have_received(:write).with("event: message\n")
        io.should have_received(:write).with(%{data: {\"hello\":\"hello\"}\n\n})
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
