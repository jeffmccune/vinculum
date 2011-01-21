namespace :facts do
    desc "Sync plugin"
    task :sync do
       system "rsync -ruv vendor/plugins/vinculum_peermap/lib/app/views/* app/views/peermap/" 
       system "rsync -ruv vendor/plugins/vinculum_peermap/lib/app/controllers/* app/controllers" 
       system "rsync -ruv vendor/plugins/vinculum_peermap/lib/public/javascript/* public/javascripts/" 
       system "rsync -ruv vendor/plugins/vinculum_peermap/lib/public/stylesheets/* public/stylesheets/" 
    end
    
    desc "Delete plugin"
    task :remove do
        system "rm -rf app/views/peermap"
        system "rm app/controllers/peermap_controller.rb"
        system "rm public/javascripts/peermap.js"
        system "rm public/stylesheets/peermap.css"
    end


end
