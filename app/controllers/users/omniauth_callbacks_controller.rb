class Users::OmniauthCallbacksController < ApplicationController
  def facebook
  	usr = User.find_for_facebook_oauth request.env["omniauth.auth"]
  	if usr.persisted?
  		flash[:notice] = (I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook") 
		  sign_in_and_redirect usr, :event => :authentication
  	else
  		flash[:danger] = "oauth fucked up"
      redirect_to root_path
  	end
  end

  def vkontakte
      usr = User.find_for_vkontakte_oauth request.env["omniauth.auth"]
      if usr.persisted?
        flash[:notice] = (I18n.t "devise.omniauth_callbacks.success", :kind => "Vkontakte") 
        sign_in_and_redirect usr, :event => :authentication
      else
        flash[:danger] = "oauth fucked up"
        redirect_to root_path
      end
    end
end
