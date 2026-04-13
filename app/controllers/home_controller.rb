class HomeController < ApplicationController
  skip_before_action :require_login

  def show
    if current_user
      redirect_to athletes_path
    else
      redirect_to new_session_path
    end
  end
end
