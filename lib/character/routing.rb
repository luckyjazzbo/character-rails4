module ActionDispatch::Routing
  class Mapper
    def mount_character_admin
      scope '/admin', :module => "Character" do
        scope 'character' do
          put '/categories-reorder', to: 'categories#reorder'
          resources :posts,      only: [:index, :create, :update, :destroy]
          resources :categories, only: [:index, :create, :update, :destroy]
          resources :images,     only: [:create]
        end
      end
    end

    def mount_character_blog_at(mount_location)
      scope mount_location, :module => "Character" do
        get '/'             => 'blog#index',    as: :blog_index
        get '/posts/:slug'  => 'blog#show',     as: :blog_post
        get '/:slug'        => 'blog#category', as: :blog_category
      end
    end
  end
end