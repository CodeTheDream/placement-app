 
class AdminsController < ApplicationController
    #prepend_before_action :require_no_authentication, only: [:cancel]
    before_action :authorize_admin
    # skip_before_action :verify_signed_out_user 
    
    def index
        @users = User.all
    end
    
    def edit
        @user = User.find(params[:id])
    end
    
    def update 
        #This gets the info from the edit form and updates the data. 
        @user = User.find(params[:id])
        @user.email = params[:user][:email]
        @user.password = params[:user][:password]
        @user.password_confirmation = params[:user][:password_confirmation]
        @user.first_name = params[:user][:first_name]
        @user.last_name = params[:user][:last_name]
        @user.phone = params[:user][:phone]
        @user.admin = params[:user][:admin]
        @user.save
        redirect_to admin_path
    end
    
    def destroy
      #byebug
      @user = User.find(params[:id])
      @user.destroy
      @user = nil
      redirect_to admin_path
    end
end
