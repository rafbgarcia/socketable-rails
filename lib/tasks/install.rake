require 'rails'
namespace :socketable do
	task :install => [:add_js_to_manifest, :remove_rack_lock_on_development]

	desc "Add config.middleware.delete(Rack::Lock)"
	task :remove_rack_lock_on_development do
		config = "config/environments/development.rb"

		def remove_middleware_code
			out = ?\n
			out << "  # Line generated by socketable:install task"
			out << ?\n
			out << "  config.middleware.delete(Rack::Lock)"
			out << ?\n
			out << 'end'
		end

		def config.middleware_removed?
			not (contents =~ /config\.middleware\.delete\(Rack::Lock\)/m).nil?
		end

		def config.contents
			open(self).read
		end

		def config.add_configuration_code
			data = contents
			data = data.split('end')
			data.delete_at(data.length-1)

			data.last.concat ?\n
			data.last.concat "  # Line generated by socketable:install task"
			data.last.concat ?\n
			data.last.concat "  config.middleware.delete(Rack::Lock)"
			data.last.concat ?\n
			data << nil

			data = data.join('end')

			open self, 'w' do |f|
				f << data
				# f << data.gsub!(/(.*)\nend/, "\1#{remove_middleware_code}")
			end
		end

		unless config.middleware_removed?
			config.add_configuration_code
		end
	end

	desc "Add socketable javascript to manifest"
	task :add_js_to_manifest do
    manifest = "app/assets/javascripts/application.js"

    def manifest.socketable_added?
			not (open(self).read =~ /\/\/= require socketable_rails\/main/m).nil?
    end

    def manifest.add_socketable_js_to_manifest
			open(self, 'a+'){ |f| f << "\n//= require socketable_rails/main\n" }
    end

    unless manifest.socketable_added?
    	manifest.add_socketable_js_to_manifest
    end
	end
end
