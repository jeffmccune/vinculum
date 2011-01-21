namespace :findhosts do
    desc "Sync plugin"
    task :sync do
       system "rsync -ruv vendor/plugins/vinculum_findhosts/lib/app/views/* app/views/findhosts/" 
       system "rsync -ruv vendor/plugins/vinculum_findhosts/lib/app/controllers/* app/controllers" 
       system "rsync -ruv vendor/plugins/vinculum_findhosts/lib/public/javascript/* public/javascripts/" 
       system "rsync -ruv vendor/plugins/vinculum_findhosts/lib/public/stylesheets/* public/stylesheets/" 
    end
    
    desc "Delete plugin"
    task :remove do
        system "rm -rf app/views/findhosts"
        system "rm app/controllers/findhosts_controller.rb"
        system "rm public/javascripts/findhosts.js"
        system "rm public/stylesheets/findhosts.css"
    end


end
