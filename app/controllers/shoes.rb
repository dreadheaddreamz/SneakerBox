require './config/environment'
class ShoesController < ApplicationController
    before_action: redirect?, set_shoe
#Read 
      #-index- like and index of ALL the shoes (get '/shoes' get request)
    get '/shoes' do
            redirect?
            @shoes = current_user.shoes
            erb :"shoes/index"
       
    end
#used twice so home button can work

   
    #Read 
      #-index- like and index of ALL the shoes (get '/shoes' get request)
    get '/shoes/new' do 
        redirect? 
        erb :"shoes/new"
    end


    post '/shoes' do
        shoe = current_user.shoes.new(params)
        
        if shoe.save
            redirect "/shoes/#{shoe.id}"
        else
            redirect '/shoes'
        end
    end
#-show- like im SHOWing you the collection.(get '/shoes/:id get request)
    get '/shoes/:id' do
        redirect?
            setshoe
            erb :"shoes/show"
    end
#-edit-Should render the form to edit shoes (get '/shoes/:id/edit' get request)
    get '/shoes/:id/edit' do
        redirect?
            setshoe
            erb :"shoes/edit"
    end

    
#-update- form is submitted. Make patch request with updated info(patch '/shoes/:id)
    patch '/shoes/:id' do
        @shoe = current_user.shoes.find_by(id: params[:id])
        if !@shoe
            redirect "/shoes"
        else
            @shoe.update(name: params[:name], date: params[:date], release: params[:release], brand: params[:brand], hyperating: params[:hyperating])
            redirect "/shoes/#{@shoes.id}"
        end

    end
#delete
    delete '/shoes/:id' do
        setshoe
        @shoe.destroy
        redirect "shoes/"
    end
#methods that can only be called by other methods in the same class(or a class that inherits from it)
    private
    def setshoe
        @shoe = Shoe.find(params[:id])
    end

    error ActiveRecord::RecordNotFound do
        
      end

end
