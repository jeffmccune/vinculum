class VinculumActionGenerator < Rails::Generator::NamedBase
	attr_reader :action_name, :args
	
    def initialize(runtime_args, runtime_options ={})
		super
		@action_name = file_name.underscore
        @args = runtime_args
	end	

    def sanity(action_name)
        @args.each_with_index do |arg, i|
            unless i == 0
                unless arg ==":with_input"
                    puts "#{arg} is not a valid argument"
                    exit(0)
                end
            end
            Dir.glob("vendor/plugins/**").each do |dir|
                if dir =~ /.*#{action_name}.*/
                    puts "Plugin or action - #{action_name} already exists. Please generate with a different name"
                    exit(0)
                end
            end
        end
    end

    def manifest
        @action_name = name
        sanity(name)
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
