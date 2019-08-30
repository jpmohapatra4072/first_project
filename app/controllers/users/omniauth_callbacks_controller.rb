# app/controllers/users/omniauth_callbacks_controllers.rb
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env['omniauth.auth'])
    puts "==================================================="
    if @user.persisted?
      puts "user present"
      if @user.provider
        flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      else
        flash[:notice] = "The email is already registered, you can reset password!!"
      end
      sign_in_and_redirect @user, event: :authentication
    else
      puts "user not present"
      session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
    puts "==================================================="
  end

  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])
    puts "==================================================="
    if @user.persisted?
      puts "user present"
      if @user.provider
        set_flash_message(:notice, :success, kind: "Facebook")
      else
        flash[:notice] = "The email is already registered, you can reset password!!" 
      end
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
    else
      puts "user not present"
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
    puts "==================================================="
  end

  def failure
    redirect_to root_path
  end
end
