class ProfileController < ApplicationController
  before_action :authenticate_user!
  before_action :remove_password_params_if_blank, only: [:update]

  # This method removes the password and password_confirmation params from the
  # form if they're left blank when updating.
  # In effect, it's like you're submitting the form without those fields when
  # they're left blank, and they are updated if you change them.
  def remove_password_params_if_blank
    if params[:user][:password].blank? &&
       params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end


  def edit
    @user = current_user
  end

  # This gets the info from the edit form and updates the data.
  def update
    @user = current_user
    @user.update_attributes(user_params)
    redirect_to root_path
  end
end
  def user_params
    params.require(:user).permit(:email, :password,
                                 :password_confirmation, :first_name,
                                 :last_name, :phone )
  end
