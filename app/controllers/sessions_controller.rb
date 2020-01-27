class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
        )

        if user
            log_in(user)
        else

        end
    end

    def destroy 
        logout
    end
end
