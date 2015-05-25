Rails.application.routes.draw do

  resources :levels

  resources :escalation_rules


  resources :contacts
  resources :organizations

  devise_for :users, :controllers => {:registrations => "registrations", :confirmations => "confirmations"}

  devise_scope :user do
    root to: "application#home"
  end

  get '/settings' => 'welcome#result', as: 'settings'
  get '/setup/1' => 'welcome#setup_1', as: 'setup_1'
  get '/setup/2' => 'welcome#setup_2', as: 'setup_2'
  post '/set_org' => 'organizations#set_organization'
  
  get '/call', to: 'call_user#caller'

  post '/calllog', to: 'odin_client#call_log'

  get '/nextcall', to: 'call_next_level#next_call'
  get '/alerts', to: 'complaint#index'
  devise_scope :user do
    get 'toggle_tour' => 'application#toggle_tour'
    get '/confirmed_email', to: 'confirmations#confirmed_email'
    get '/check_phone_number_verification_status', to: 'confirmations#check_phone_number_verification_status'
  end
end
