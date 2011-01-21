class FindhostsController < ApplicationController
    require 'mcollective'
    include MCollective::RPC

    def get_findhosts
        render :update do |page|
            page.replace_html("inputContent", :partial => "input")
            page << "openPopup('inputWindow')" 
        end
    end

    def do_findhosts
        @fact = params[:fact]
        @pclass = params[:pclass]
        @identity = params[:identity]
        fact = params[:fact].split(" ")
        #fact = MCollective::Util.parse_fact_string(params[:fact]) unless params[:fact] == ""
        client = rpcclient("discovery")
        unless fact.size > 1
            client.fact_filter fact[0], fact[1] unless fact == ""
        else
            fact.each do |f|
                f = f.split("=")
                client.fact_filter f[0], f[1] unless fact == ""
            end
        end
        client.class_filter Regexp.new(params[:pclass]) unless params[:pclass] == ""
        client.identity_filter Regexp.new(params[:identity]) unless params[:identity] ==""

        @results = client.discover

        render :update do |page|
            page.replace_html("popupContent", :partial => "findhosts")
            page << "closePopup()"
            page << "openPopup('popupWindow')"
        end
    end
end
