require 'transmitter/sse'

describe Transmitter::SSE do
  let(:io) { double('io', write: true, close: true) }
  let(:sse) { Transmitter::SSE.new(io) }
  let(:expected_message) { "event: message\nretry: 1000\ndata: {\"hello\":\"hello\"}\n\n" }

  describe '#write' do
    context 'with a retry specified' do
      it 'sends data accross the pipe in the correct format' do
        sse.build_message(event: 'message', retry: 1000, data: { hello: 'hello' }).stream
        io.should have_received(:write).with(expected_message)
      end
    end
  end

  describe '#close' do
    it 'closes the IO connection' do
      sse.close
      io.should have_received(:close)
    end
  end
end
