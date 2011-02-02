class ApplicationController < ActionController::Base
  require 'mcollective'
  include MCollective::RPC
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  rescue_from Exception do |exception|
      @e = exception
      render :update do |page|
          page.replace_html("popupContent", :partial => "puppet/error")
          page << "spin();"
          page << "closePopup();"
          page << "openPopup('popupWindow');"
      end unless performed?
   end
end
