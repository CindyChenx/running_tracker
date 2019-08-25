class RunsController < ApplicationController

    get '/runs' do     
        authenticate
        @runs = Run.all
        erb :'runs/index'
    end

    get '/runs/new' do  
        authenticate  
        erb :'runs/new'
    end

    post '/runs' do     
        authenticate
        u = current_user
        u.runs.build(distance: params[:distance], time: params[:time], mood: params[:mood])
        if u.save
            redirect "/users/#{u.id}"
        else
            @error_message = "There was an error adding your data."
            erb :'runs/new'
        end
    end

    delete '/runs/:id' do
        run = Run.find_by(id: params[:id])
        return authenticate_user(run)
        u = current_user
        if run
            run.destroy   
            redirect "/users/#{u.id}"
        end
    end

    get '/runs/:id/edit' do
        @run = Run.find_by(id: params[:id])
        return authenticate_user(@run)
        erb :'runs/edit'
    end

    patch '/runs/:id' do
        u = current_user
        @run = Run.find_by(id: params[:id])
        return authenticate_user(@run)
        @run.update(distance: params[:distance], time: params[:time], mood: params[:mood])
        redirect "/users/#{u.id}"
    end
end