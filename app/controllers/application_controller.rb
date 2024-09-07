class ApplicationController < ActionController::Base
  def auth_user
      redirect_to :root unless user_signed_in?
    end
end
