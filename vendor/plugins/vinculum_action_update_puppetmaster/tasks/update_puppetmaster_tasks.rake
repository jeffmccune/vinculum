namespace :update_puppetmaster do
    desc "Sync action"
    task :sync do
       system "rsync -ruv vendor/plugins/vinculum_action_update_puppetmaster/lib/app/views/* app/views/update_puppetmaster/" 
       system "rsync -ruv vendor/plugins/vinculum_action_update_puppetmaster/lib/app/controllers/* app/controllers" 
       system "rsync -ruv vendor/plugins/vinculum_action_update_puppetmaster/lib/public/javascript/* public/javascripts/" 
       system "rsync -ruv vendor/plugins/vinculum_action_update_puppetmaster/lib/public/stylesheets/* public/stylesheets/" 
    end
    
    desc "Delete action"
    task :remove do
        system "rm -rf app/views/actions/update_puppetmaster"
        system "rm app/controllers/update_puppetmaster_controller.rb"
        system "rm public/javascripts/update_puppetmaster.js"
        system "rm public/stylesheets/update_puppetmaster.css"
    end


end
