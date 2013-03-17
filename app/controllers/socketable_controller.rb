class SocketableController < WebsocketRails::BaseController
  attr_accessor :params

  # Handle all requests
	def request
    begin
      @params = formated_params
      controller.new.websocket(params, self)
  	rescue Exception => e
      error_message e
  	end
  end

  def emit(data, to_event)
    send_message(to_event, data)
  end

  def broadcast(data, to_event)
    broadcast_message(to_event, data)
  end


  private

  def formated_params
    params = {}
    Rack::Utils.parse_nested_query(data).each do |key, value|
      key  = key.to_sym
      params[key] = value
    end
    params[:path] = Rails.application.routes.recognize_path(params[:path])
    params
  end

  def error_message(e)
    puts "-- Error in websocket function"
    puts e.message
  end

  def controller
    "#{@params[:path][:controller]}_controller".camelize.constantize
  end

end
