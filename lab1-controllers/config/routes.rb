ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  
  map.connect "/links/add_link", :controller => "links", :action => "add_link"
  map.connect "/links/edit_link", :controller => "links", :action => "edit_link"
  map.connect "/links/update_link", :controller => "links", :action => "update_link"
  map.connect "/links/delete_link", :controller => "links", :action => "delete_link"
  map.connect "/links", :controller => "links", :action => "list"

  map.connect "/tags/tags_for", :controller => "tags", :action => "tags_for"
  map.connect "/tags/add_tag", :controller => "tags", :action => "add_tag"
  map.connect "/tags/delete_tag", :controller => "tags", :action => "delete_tag"

  map.connect "/", :controller => "links", :action => "list"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
