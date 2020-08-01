class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

#   user_params method allows us to specify which pa-
# rameters are required and which ones are permitted. In addition, passing in a
# raw params hash as above will cause an error to be raised, so that Rails appli-
# cations are now immune to mass assignment vulnerabilities by default.
  def create
    @user = User.new(user_params)
    if @user.save
      # sucsseful save
    else
      render 'new'
    end
  end

  private

    # Since user_params will only be used internally by the Users controller and
    # need not be exposed to external users via the web, we’ll make it private using
    def user_params 
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
