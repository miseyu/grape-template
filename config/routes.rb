Rails.application.routes.draw do
  root controller: :index, action: :index
  mount RootAPI => "/"
end
