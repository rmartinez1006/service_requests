class Administration::UserSessionsController < ApplicationController

  layout "login"

  def new
      @administration_user_session = Administration::UserSession.new
  end

  def create
    @administration_user_session = Administration::UserSession.new(params[:administration_user_session])
    if @administration_user_session.save
      flash[:notice] = "Sessión de usuario abierta"
      redirect_to administration_users_path
    else
      render :action => 'new'
    end
  end

  def destroy
    @administration_user_session = Administration::UserSession.find
    @administration_user_session.destroy
    flash[:notice] = "Sessión de usuario cerrada."
    redirect_to administration_login_path
  end

end
