require './config/environment'
class ShoesController < ApplicationController
    get '/shoes' do
        if logged_in?
            @user = current_user
            @shoes = @user.shoes
            erb :"shoes/index"
        else
        redirect '/login'
        end
    end

    get '/shoes/new' do 
        if logged_in?
            erb :"shoes/new"
        else
            redirect '/login'
        end
    end

    get '/shoes/:id' do
        @shoe = Shoe.find(params[:id])
        erb :"shoe/show"
    end

    post '/shoes/new' do
        binding.pry
        shoe = current_user.shoes.new(params)
        
        if shoe.save
            redirect '/shoes/#{shoe.id}'
        else shoe.save
            redirect '/shoes'
        end
    end
end