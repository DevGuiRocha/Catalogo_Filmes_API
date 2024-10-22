Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :movies, only: [:index] do
        collection do
          post :import_csv
        end
      end
    end
  end
end
