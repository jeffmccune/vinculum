class FactsController < ApplicationController
    def get_facts
        render :update do |page|
            page.replace_html("inputContent", :partial => "input")
            page << "openPopup('inputWindow')"
        end
    end

    def do_facts
        client = rpcclient("rpcutil")
        @facts = {}
        @search_fact = params[:fact]
        client.get_fact(:fact => @search_fact) do |resp|
            value = resp[:body][:data][:value]
            if value
                @facts.include?(value) ? @facts[value] << resp[:senderid] : @facts[value] = [resp[:senderid]]
            end
        end
        client.disconnect
        render :update do |page|
            page.replace_html("popupContent", :partial => "facts")
            page << "closePopup()"
            page << "openPopup('popupWindow')"
        end
        
    end
end
