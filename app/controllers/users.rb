class UsersController < ApplicationController

    get '/signup' do 
        erb :'users/signup'
    end
    
    post '/signup' do
        user = User.new(params)
    if user.save
        session[:user_id]= user.id
        redirect '/shoes'
    else
        @error = "Username and Password Required!"
        erb :'users/signup'
        end
      end
    end