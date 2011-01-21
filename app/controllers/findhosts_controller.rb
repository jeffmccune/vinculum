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
        fact = params[:fact].split(" ") unless params[:fact] == ""
        client = rpcclient("discovery")
    
        if fact
            unless fact.size > 1
                client.fact_filter fact[0], fact[1] unless fact == ""
            else
                fact.each do |f|
                    f = f.split("=")
                    client.fact_filter f[0], f[1] unless fact == ""
                end
            end
        end

        if @pclass =~ /\/.*/
            @plcass = @pclass.gsub("/", "")
            client.class_filter Regexp.new(@plcass)
        else
            client.class_filter @pclass unless @pclass == ""
        end

        if @identity =~ /\/.*/
            @identity = @identity.gsub("/", "")
            client.identity_filter Regexp.new(@identity)
        else
            client.identity_filter @identity unless @identity == ""
        end

        @results = client.discover

        render :update do |page|
            page.replace_html("popupContent", :partial => "findhosts")
            page << "closePopup()"
            page << "openPopup('popupWindow')"
        end
    end
end
