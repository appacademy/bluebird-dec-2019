class UsersController < ApplicationController

    before_action :require_login, only: [:index, :show]

    def new
        @user = User.new
        render :new
    end

    def create
        user = User.new(user_params)
        
        if user.save               
            log_in(user)
            redirect_to user_url(user)
        else 
            flash[:errors] = user.errors.full_messages   
            render :new  
        end
    end
    
    def index 
        @users = User.all 
        render :index
    end 

    def show 
        @user = User.find_by(id: params[:id])
        render :show 
    end 

    def edit
        @user = User.find(params[:id])
        render :edit
    end
    
    def update
        user = User.find(params[:id])
        if user.update(user_params)
            # render json: user 
            #redirect_to "/users/#{user.id}" #get verb 
            #redirect_to users_url(user.id)
            redirect_to user_url(user) 
        else
            render json: user.errors.full_messages, status: 422

        end
    end

    def destroy
        @user = User.find_by(id: params[:id])
        @user.destroy #ActiveRecord method 
        # render json: user #we still have access to the local variable 'user'
        redirect_to users_url
    end

    def user_params 
        params.require(:user).permit(:username,:password, :email, :age)
    end
    
end
