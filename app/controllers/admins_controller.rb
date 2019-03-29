 
class AdminsController < ApplicationController
    #prepend_before_action :require_no_authentication, only: [:cancel]
    before_action :authorize_admin, except: [:index]
    # skip_before_action :verify_signed_out_user 
    
    def show
        @users = User.all
    end
    
    def edit
        @user = User.find(params[:id])
    end
    
    def update 
        @user = User.find(params[:id])
        @user.email = params[:user][:email]
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