class Administration::UserSessionsController < ApplicationController

  layout "login"

  def new
      @administration_user_session = Administration::UserSession.new
  end

  def create
    @administration_user_session = Administration::UserSession.new(params[:administration_user_session])
    if @administration_user_session.save
       lv_role_id = Administration::UserSession.find.record.attributes['role_id']
       @UserRole = Administration::UserRole.find(:first, :conditions => "id = " + lv_role_id.to_s)
       @administration_user_session.record.update_attribute(:role , @UserRole.rol)
         #record.attributes['role'] = 'ADMIN'
         #record.attribute(:role, @UserRole.rol)
     
      flash[:notice] = "Sesión de usuario abierta"
      redirect_to administration_users_path      
    else
      render :action => 'new'
    end
  end

  def destroy
    @administration_user_session = Administration::UserSession.find
    @administration_user_session.destroy
    flash[:notice] = "Sesión de usuario cerrada."
    redirect_to administration_login_path
  end

end
