namespace :pokeme do
    desc "Sync action"
    task :sync do
       system "rsync -ruv vendor/plugins/vinculum_action_pokeme/lib/app/views/* app/views/pokeme/" 
       system "rsync -ruv vendor/plugins/vinculum_action_pokeme/lib/app/controllers/* app/controllers" 
       system "rsync -ruv vendor/plugins/vinculum_action_pokeme/lib/public/javascript/* public/javascripts/" 
       system "rsync -ruv vendor/plugins/vinculum_action_pokeme/lib/public/stylesheets/* public/stylesheets/" 
    end
    
    desc "Delete action"
    task :remove do
        system "rm -rf app/views/actions/pokeme"
        system "rm app/controllers/pokeme_controller.rb"
        system "rm public/javascripts/pokeme.js"
        system "rm public/stylesheets/pokeme.css"
    end


end
