class UserProfileController < ApplicationController

    def show
        @profile = User.find(params[:id])
    end 
end
