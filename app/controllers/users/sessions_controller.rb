# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :redirect_if_logged_in, only: [:new]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private

  def redirect_if_logged_in
    if user_signed_in?
      redirect_to feeds_path, notice: "You are already logged in."
    end
  end
end
