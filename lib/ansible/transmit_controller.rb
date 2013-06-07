module Ansible
  module TransmitController
    def transmit(event, message)
      begin
	headers['Content-Type'] = 'text/event-stream'
	sse = SSE.new response.stream
	sse.write event, message
      ensure
	response.stream.close
      end
    end
  end
end
