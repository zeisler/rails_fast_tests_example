Rails.application.routes.draw do
  get '/' => 'orders#edit'
  post '/' => 'orders#create'
end
