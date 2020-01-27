class UsersController < ApplicationController
    before_action :require_login, only: [:index,:show]
    
    def index 
        @users = User.all #User is the model. No need to require User at the top. 
        render :index
        # render json: @users
    end 

    def show 
        
        @user = User.find_by(id: params[:id])
        render :show 
        #cannot render and redirect
    end 

    def new
        @user = User.new
        render :new
    end

    def create
        # debugger
        # user = User.new(
        #     username: params[:username],
        #     email: params[:email],
        #     age: params[:age],
        #     political_affiliation: params[:political_affiliation]
        # )

        #user = User.new(params[:user]) 

        user = User.new(user_params)
    
        if user.save #saves and returns either truthy or falsey 
            #save will return false if it doesn't save
            #save! raises a validation error, and we will not reach our else condition. 
            # render json: user
            log_in(user)
            redirect_to user_url(user)
        else 
            # debugger
            #render plain: 'no working '
            render json: user.errors.full_messages, status: 418            
        end

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
        params.require(:user).permit(:username,:password,:email, :age, :political_affiliation)
    end
    
end
