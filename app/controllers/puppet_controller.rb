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
        @is_cached = false
        unless @inventory.empty?
            @inventory = @inventory[0].results
        else
            @is_cached = true
            @inventory={:data => {:agents => nil,
                                  :classes => nil,
                                  :facts => nil
                                  },
                        :sender => nil

                        }
            db = Mongo::Connection.new.db("puppet")
            db["nodes"].find({"fqdn" => params[:fqdn]}).each do |node|
                node.each do |symme|
                    if symme[0] == "agentlist"
                        @inventory[:data][:agents] = symme[1]
                    elsif symme[0] == "classes"
                        @inventory[:data][:classes] = symme[1]
                    elsif symme[0] == "facts"
                        @inventory[:data][:facts] = symme[1]
                     end
                end
            end
        end
        @inventory[:sender] = params[:fqdn]

        agent.disconnect
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
                    page << "openPopup('popupWindow');"
                end
            }
        end
    end

end
