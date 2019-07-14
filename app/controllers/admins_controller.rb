# frozen_string_literal: true

class AdminsController < ApplicationController
  # prepend_before_action :require_no_authentication, only: [:cancel]
  before_action :authenticate_user!
  before_action :authorize_admin
  # skip_before_action :verify_signed_out_user
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

  def index
    @users = User.all
    @services = Service.all
  end

  def edit
    @user = User.find(params[:id])
  end

  # This gets the info from the edit form and updates the data.
  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    redirect_to admins_path
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    @user = nil
    redirect_to admins_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password,
                                 :password_confirmation, :first_name,
                                 :last_name, :phone, :admin)
  end
end
