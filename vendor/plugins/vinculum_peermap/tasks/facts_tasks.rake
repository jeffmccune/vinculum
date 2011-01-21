namespace :facts do
    desc "Sync plugin"
    task :sync do
       system "rsync -ruv vendor/plugins/vinculum_facts/lib/app/views/* app/views/facts/" 
       system "rsync -ruv vendor/plugins/vinculum_facts/lib/app/controllers/* app/controllers" 
       system "rsync -ruv vendor/plugins/vinculum_facts/lib/public/javascript/* public/javascripts/" 
       system "rsync -ruv vendor/plugins/vinculum_facts/lib/public/stylesheets/* public/stylesheets/" 
    end
    
    desc "Delete plugin"
    task :remove do
        system "rm -rf app/views/facts"
        system "rm app/controllers/facts_controller.rb"
        system "rm public/javascripts/facts.js"
        system "rm public/stylesheets/facts.css"
    end


end
