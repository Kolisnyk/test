class Admins::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
layout false
  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    @admin = Admin.find_by_login(params[:admin][:login])
    if @admin != nil
      if !@admin.active
        flash[:notice] = "#{ @admin.login } do not have access."
        redirect_to new_session_path(Admin)
      else
        super
      end
    else
      super
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
