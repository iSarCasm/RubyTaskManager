class Users::OmniauthCallbacksController < ApplicationController
  def facebook
  	usr = User.find_for_facebook_oauth request.env["omniauth.auth"]
  	if usr.persisted?
		  sign_in_and_redirect usr, :event => :authentication
  	else
      redirect_to root_path
  	end
  end

  def vkontakte
      usr = User.find_for_vkontakte_oauth request.env["omniauth.auth"]
      if usr.persisted?
        sign_in_and_redirect usr, :event => :authentication
      else
        redirect_to root_path
      end
    end
end
