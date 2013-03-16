class SocketableRails::SocketableController < WebsocketRails::BaseController

	def request
  	params = {}
  	Rack::Utils.parse_nested_query(data).each do |k, v|
  		k = k.to_sym
  		params[k] = v
  	end

  	url = Rails.application.routes.recognize_path(params[:path])

  	controller = "#{url[:controller]}_controller".camelize.constantize
  	begin
  		controller.new.websocket(params, self)
  	rescue Exception => e
  		puts "-- Error in websocket function"
  		puts e.message
  	end
  end


end
