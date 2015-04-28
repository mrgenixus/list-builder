class CallbacksController < Devise::OmniauthCallbacksController
  def sign_in
    if current_user
      if current_user.update_from_omniauth(request.env["omniauth.auth"])
        flash.notice = "Authentication provider updated"
        redirect_to :meals
      else
        flash.notice = "Authentication provider not updated"
      end
    else
      user = User.from_omniauth(request.env["omniauth.auth"])
      if user.persisted?
        flash.notice = "Signed in!"
        sign_in_and_redirect user
      else
        flash[:errors] = user.errors.full_messages.to_sentence if user.errors
        session["devise.user_attributes"] = user.attributes
        redirect_to new_user_session_path
      end
    end
  end
  alias_method :google_oauth2, :sign_in
  alias_method :github, :sign_in
end
