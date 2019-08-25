class UsersController < ApplicationController

    get '/users' do
        @users = User.all
        erb :'users/index'
    end

    post '/users' do    
        @user = User.create(name: params[:name], username: params[:username], password: params[:password])
        if @user.errors.any?
            @errors = @user.errors.messages
            erb :'sessions/signup'
        else
            session[:user_id] = @user.id
            redirect '/home'
        end
    end

    get '/users/:id' do
        @user = User.find_by(id: params[:id])
        erb :'users/show'
    end
    
end