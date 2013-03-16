class SocketableController < WebsocketRails::BaseController

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

  # def url
  # 	url = Rails.application.routes.recognize_path(params[:path])
  # end

  # def params
  # 	return @params unless @params.empty?

  # 	@params = {}
  # 	Rack::Utils.parse_nested_query(data).each do |key, value|
  # 		key = key.to_sym
  # 		@params[key] = value
  # 	end
  # end

end
