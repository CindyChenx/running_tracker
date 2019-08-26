class RunsController < ApplicationController

    get '/runs' do     
        authorize
        @runs = Run.all
        erb :'runs/index'
    end

    get '/runs/new' do  
        authorize  
        erb :'runs/new'
    end

    post '/runs' do     
        authorize
        u = current_user
        u.runs.build(distance: params[:distance], time: params[:time], mood: params[:mood])
        raise PostSiteError.new if !u.save
        # redirect '/users/#{u.id}'
        redirect '/runs'
    end

    delete '/runs/:id' do
        run = Run.find_by(id: params[:id])
        authorize_user(run)
        u = current_user
        if run
            run.destroy   
            redirect "/users/#{u.id}"
        end
    end

    get '/runs/:id/edit' do
        @run = Run.find_by(id: params[:id])
        authorize_user(@run)
        erb :'runs/edit'
    end

    patch '/runs/:id' do
        u = current_user
        @run = Run.find_by(id: params[:id])
        authorize_user(@run)
        @run.update(distance: params[:distance], time: params[:time], mood: params[:mood])
        redirect "/users/#{u.id}"
    end
end