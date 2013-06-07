module Ansible
  module TransmitController
    def transmit(event, message)
      set_headers
      sse.write event, message unless stream_closed?
    end

    def close_connection
      response.stream.close
    end

    def stream_closed?
      response.stream.closed?
    end

    def set_headers
      return if headers['Content-Type'] == 'text/event-stream'
      headers['Content-Type'] = 'text/event-stream'
    end

    def sse
      @sse ||= SSE.new response.stream
    end
  end
end
