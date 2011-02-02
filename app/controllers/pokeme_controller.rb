class PokemeController < ApplicationController
    def get_pokeme
        render :update do |page|
            page << "spin();"
            page.replace_html("inputContent", :partial => "input")
            page << "openPopup('inputWindow')"
        end
    end
    
    def do_pokeme
        @recipient = params[:recipient]
        @subject = params[:subject]
        @message = params[:message]

        client = rpcclient("naggernotify")
        @results = client.sendmsg(:recipient => @recipient, 
                                    :subject => @subject, 
                                    :message => @message)

        render :update do |page|
            page.replace_html("popupContent", :partial =>"pokeme")
            page << "spin();"
            page << "closePopup();"
            page << "openPopup('popupWindow');"
        end
    end
end
