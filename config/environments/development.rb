WebsocketTestApp::Application.configure do
  config.middleware.delete Rack::Lock
end
