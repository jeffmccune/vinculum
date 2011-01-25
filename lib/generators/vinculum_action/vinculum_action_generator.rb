class VinculumActionGenerator < Rails::Generator::NamedBase
	attr_reader :action_name
	
    def initialize(runtime_args, runtime_options ={})
		super
		@action_name = file_name.underscore
	end	

    def manifest
        @action_name = name
        record do |m|
            m.directory "vendor/plugins/vinculum_action_#{@action_name}/"
            m.template "init.rb.erb", "vendor/plugins/vinculum_action_#{@action_name}/init.rb"

            m.directory "vendor/plugins/vinculum_action_#{@action_name}/lib"
            m.template "lib/app/helpers/helpers.rb.erb", "vendor/plugins/vinculum_action_#{@action_name}/lib/#{@action_name}.rb"

            m.directory "vendor/plugins/vinculum_action_#{@action_name}/lib/public/javascript"
            m.directory "vendor/plugins/vinculum_action_#{@action_name}/lib/public/stylesheets"
            m.directory "vendor/plugins/vinculum_action_#{@action_name}/lib/app/controllers"
            m.directory "vendor/plugins/vinculum_action_#{@action_name}/lib/app/helpers"
            m.directory "vendor/plugins/vinculum_action_#{@action_name}/lib/app/views/"
            m.directory "vendor/plugins/vinculum_action_#{@action_name}/tasks"

            m.file "lib/public/javascript/javascript.js", "vendor/plugins/vinculum_action_#{@action_name}/lib/public/javascript/#{@action_name}.js"
            m.file "lib/public/stylesheets/stylesheets.css", "vendor/plugins/vinculum_action_#{@action_name}/lib/public/stylesheets/#{@action_name}.css"

            m.template "lib/app/views/view.html.erb", "vendor/plugins/vinculum_action_#{@action_name}/lib/app/views/_#{@action_name}.html.erb"
            m.template "tasks/plugin_tasks.rake.erb", "vendor/plugins/vinculum_action_#{@action_name}/tasks/#{@action_name}_tasks.rake"

            if ARGV[1] == ":with_input"
                m.template "lib/app/views/input.html.erb", "vendor/plugins/vinculum_action_#{@action_name}/lib/app/views/_input.html.erb"
                m.template "lib/app/controllers/controller_with_input.rb.erb", "vendor/plugins/vinculum_action_#{@action_name}/lib/app/controllers/#{@action_name}_controller.rb"
            else
            m.template "lib/app/controllers/controller.rb.erb", "vendor/plugins/vinculum_action_#{@action_name}/lib/app/controllers/#{@action_name}_controller.rb"
            end
        end
    end

end
