class UpdatePuppetmasterController < ApplicationController
    def get_update_puppetmaster
        client = rpcclient("vcsmgr")
        client.class_filter "puppet::master"
        @results = client.svn_update(:path => "/etc/puppet/manifests")
        render :update do |page|
            page <<"spin();"
            page.replace_html("popupContent", :partial => "update_puppetmaster")
            page << "openPopup('popupWindow');"
        end
    end
    
end
