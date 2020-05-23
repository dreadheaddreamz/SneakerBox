require './config/environment'
class ShoesController < ApplicationController
#Read 
      #-index- like and index of ALL the shoes (get '/shoes' get request)
    get '/shoes' do
        if logged_in?
            @user = current_user
            @shoes = @user.shoes
            erb :"shoes/index"
        else
        redirect '/login'
        end
    end
#used twice so home button can work
    get '/shoes/' do
        if logged_in?
            @user = current_user
            @shoes = @user.shoes
            erb :"shoes/index"
        else
        redirect '/login'
        end
    end
    #Read 
      #-index- like and index of ALL the shoes (get '/shoes' get request)
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
#-show- like im SHOWing you the collection.(get '/shoes/:id get request)
    get '/shoes/:id' do
        if logged_in? & current_user
        setshoe
        erb :"shoes/show"
        else
            redirect "/login"
        end
    end
#-edit-Should render the form to edit shoes (get '/shoes/:id/edit' get request)
    get '/shoes/:id/edit' do
        if current_user
        setshoe
        erb :"shoes/edit"
        else
            redirect "/login"
        end
    end

    post "/shoes/:id" do
        setshoe
        erb :"shoes/edit"
    end

    patch '/shoes/:id' do
        @user = current_user
        @shoes = @user.shoes.find_by(id: params[:id])
        if !@user
            redirect "/login"
        else
            @shoes.update(name: params[:name], date: params[:date], release: params[:release], brand: params[:brand], hyperating: params[:hyperating], user_id: @user.id)
            redirect "/shoes/#{@shoes.id}"
            end

    end

    delete '/shoes/:id' do
        setshoe
        @shoe.destroy
        redirect "shoes/"
    end

    private
    def setshoe
        @shoe = Shoe.find(params[:id])
    end

    error ActiveRecord::RecordNotFound do
        
      end

end
