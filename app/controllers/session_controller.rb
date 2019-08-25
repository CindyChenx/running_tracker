class SessionController < ApplicationController

    get '/login' do
        redirect '/home' if logged_in?
        @failed = false
        erb :'sessions/login'
    end

    post '/login' do    
        user = User.find_by(username: params[:username])
        if !!user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/home'
        else
            @failed = true
            erb :'sessions/login'
        end
    end

    get '/signup' do
        redirect '/home' if logged_in?
        erb :'sessions/signup'
    end

    # post '/users' do    
    #     @user = User.create(name: params[:name], username: params[:username], password: params[:password])
    #     if @user.errors.any?
    #         @errors = @user.errors.messages
    #         erb :'sessions/signup'
    #     else
    #         session[:user_id] = @user.id
    #         redirect '/home'
    #     end
    # end

end