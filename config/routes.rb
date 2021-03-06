# https://guides.rubyonrails.org/routing.html
#
# Conventional expectations:
# - Define a route that points to a controller#action.
#
# - Have an appropriately named controller. For example:
#   - If dealing with layouts or static pages of an app,
#     a name could be "pages_controller".
#
# - Have an appropriately named action. For example:
#   - If dealing with a home page, the action/method
#     could be named "home".
#
# - If done this way, under "views", rails will expect:
#   - A "pages" folder (named for pages_controller) and
#   - A "home.html.erb" template (named for home action).
#
# REST means Representational State Transfer -
#   Mapping HTTP verbs:
#     - Frontend requests (get, post, delete, etc)
#   to CRUD actions:
#     - Backend methods (show, index, destroy, etc).

Rails.application.routes.draw do
  # Note to self --> get('webpage', to: 'controller#action').
  root('pages#home')

  get('about', to:'pages#about')
  get('monke_gallery', to: 'pages#monke_gallery')
  get('monke_replies', to: 'pages#monke_replies')
  get('monke_info', to: 'pages#monke_info')
  get('monkey_types', to: 'monkey_types#index')

  get('signup', to: 'users#new')
  # For handling user login sessions.
  get('login', to: 'sessions#new')
  post('login', to: 'sessions#create')
  delete('logout', to: 'sessions#destroy')

  # Resources provide RESTful routes to Rails resources.
  # "only:" means only generate routes for the given actions.
  # https://guides.rubyonrails.org/routing.html#crud-verbs-and-actions
  resources(:articles, only: [:show, :index, :new, :create, :edit, :update, :destroy])
  resources(:users, except: [:new])
  resources(:monkey_types, except: [:destroy])

end
