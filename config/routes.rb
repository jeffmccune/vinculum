ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'puppet', :action => 'index'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
