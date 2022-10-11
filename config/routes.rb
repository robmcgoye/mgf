Rails.application.routes.draw do
  pages = %w(about history mission philosophy links photographer_1 photographer_2 
              photographer_3 contact)
  
  
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root 'pages#home'    
    pages.each do |page|
      get "#{page}", to: "pages##{page}"
    end
    resources :pages, only: [:edit, :update, :show]
    post 'tinymce_assets', to: 'tinymce_assets#create'
    resources :contact_forms, only: [:new, :create]
    resources :galleries 
    resources :events 
    resources :libraries 
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
  end
  
  mount Blazer::Engine, at: "blazer"

  # match '*path', to: redirect("/#{I18n.default_locale}/%{path}")
  # match '', to: redirect("/#{I18n.default_locale}")

end
