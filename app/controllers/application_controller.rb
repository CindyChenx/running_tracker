class ApplicationController < Sinatra::Base   


    configure do    
        set :views, 'app/views'
        set :public_folder, 'public'
        enable :sessions
        set :session_secret, SESSION_SECRET

    end


    get '/' do
        erb :index
    end

    get '/home' do   
        authenticate 
        erb :home
    end

    get '/logout' do     
        session.clear 
        redirect '/'
    end

    helpers do 

        def logged_in?   
            !!session[:user_id]
        end

        def current_user
            User.find_by(id: session[:user_id])
        end

        def authenticate
            if !logged_in?
                redirect '/login'
            end
        end

        def authenticate_user(run)
            authenticate
            if !run
                @message = "There is no record founded."
                return erb :error
            end
            if current_user != run.user
                @message = "You do not have access to this data."
                return erb :error
            end
        end

    end
end