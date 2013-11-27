class SessionsController < ApplicationController

  def new
    @title = "Sign In"
  end

  def create
    marker = Marker.authenticate(params[:session][:email],
                                 params[:session][:password])
    if marker.nil?
      @title = "Sign In"
      redirect_to root_path, :alert => "Invalid email/password combination."
    else
      sign_in marker
      redirect_to marker
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
