class PuppetController < ApplicationController
    require 'mcollective'
    require 'mongo'
    include MCollective::RPC

    layout 'layout'

    def index
        if params[:position]
            @position = params[:position]
        else
            @position = 1
        end

        respond_to do |format|
            format.html
            format.js{ render :layout => false}
        end
    end

    def get_inventory
        agent = rpcclient("rpcutil")
        @inventory = agent.custom_request("inventory", {}, params[:fqdn], {"identity" => params[:fqdn]})
        @inventory = @inventory[0].results

        respond_to do |format|
            format.js{
                render :update do |page|
                   page.replace_html("popupContent", :partial => "inventory")
                   page << "openPopup('popupWindow');"
                end
            }
        end
    end
    
    def get_status
        agent = rpcclient("puppetd")
        @status = agent.custom_request("status", {}, params[:fqdn], {"identity" => params[:fqdn]})
        @status = @status[0].results

        respond_to do |format|
            format.js{
                render :update do |page|
                    page.replace_html("popupContent", :partial => "status")
                    page << "openPopup('popupWindow');"
                end
            }
        end
    end

    def enable_puppet
        agent = rpcclient("puppetd")
        @enable = agent.custom_request("enable", {}, params[:fqdn], {"identity" => params[:fqdn]})
        @enable = @enable[0].results

        respond_to do |format|
            format.js{
                render :update do |page|
                    page.replace_html("popupContent", :partial => "enable")
                    page << "openPopup('popupWindow');"
                end
            }
        end
    end

    def disable_puppet
        agent = rpcclient("puppetd")
        @disable = agent.custom_request("disable", {}, params[:fqdn], {"identity" => params[:fqdn]})
        @disable = @disable[0].results

        respond_to do |format|
            format.js{
                render :update do |page|
                    page.replace_html("popupContent", :partial => "disable")
                    page << "openPopup();"
                end
            }
        end
    end

    def show_facts #depricate and remove
        @facts = []
        db = Mongo::Connection.new.db("puppet")
        db["nodes"].find({"fqdn" => params[:fqdn]}, :fields => ["facts"]).each do |node|
            node["facts"].each do |fact, value|
                 @facts << "#{fact} - #{value}"
            end
        end

        respond_to do |format|
            format.js {
                render :update do |page|
                    page.replace_html("popupContent", :partial => "facts")
                    page << "openPopup();"
                end

            }
        end
    end
end
