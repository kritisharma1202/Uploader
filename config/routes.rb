Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match 'file_import/show' => 'file_import#show', :via => :post
  match 'file_import/new' => 'file_import#new', :via => :get

end
