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


    post '/shoes/new' do
        shoe = current_user.shoes.new(params)
        
        if shoe.save
            redirect "/shoes/#{shoe.id}"
        else shoe.save
            redirect '/shoes'
        end
    end

    get '/shoes/:id' do
        setshoe
        erb :"shoes/show"
    end

    get '/shoes/:id/edit' do
        setshoe
        erb :"shoes/edit"
    end

    patch '/shoes/:id' do
        setshoe
        new_info = params.reject!{|k| k == "_method"}
        @shoe.update(new_info)
        redirect "/shoes"
    end

    delete '/shoes/:id' do
        setshoe
        @shoe.destroy
        erb :"shoes/index"
    end

    private
    def setshoe
        @shoe = Shoe.find(params[:id])
    end
    
end