# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
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

Rails.application.routes.draw do
  # The default page to load.
  root('pages#home')
  # Load about page when requesting /about.
  get('about', to:'pages#about')
  # Article resources.
  # "only:" means only generate routes for the given actions.
  resources(:articles, only: [:show, :index, :new, :create])
end
