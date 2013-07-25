require 'transmitter/sse'

describe Transmitter::SSE do
  let(:io) { stub(write: true, close: true) }
  let(:sse) { Transmitter::SSE.new(io) }
  let(:mutex) { Mutex.new }

  describe '#write' do
    context 'with an event specified' do
      it 'sends data accross the pipe in the correct format' do
        mutex.lock do
          sse.write(:message, 1000, hello: 'hello')
          io.should have_received(:write).with("event: message\nretry: 1000\ndata: \"event: message\\nretry: 1000\\n\"\n\n")
        end
      end
    end
  end

  describe '#close' do
    it 'closes the IO connection' do
      mutex.lock do
        sse.close
        io.should have_received(:close)
      end
    end
  end
end
