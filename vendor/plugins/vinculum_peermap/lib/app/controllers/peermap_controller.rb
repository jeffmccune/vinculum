class PeermapController < ApplicationController
    include MCollective::RPC
    def get_peermap
        client = rpcclient("stomputil")
        @peers = {}
        peer_resp_times = {}

        starttime = nil

        client.peer_info do |resp|
           starttime = Time.now.to_f

           data = resp[:body][:data]
           desthost = data[:desthost]

           @peers[desthost] ||={:hosts => [], :pings => []}
           @peers[desthost][:hosts] << resp[:senderid]
           @peers[desthost][:pings] << Time.now.to_f - starttime
        end

       render :update do |page|
           page.replace_html("popupContent", :partial => "peermap")
           page << "openPopup();"
       end

    end
end
