class Notifier < ActionMailer::Base
  include Common

  default :from => "rmo1006@gmail.com"

  def path_url
    #return '192.168.1.74:3000'
    return '132.248.142.10:3051'
  end


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_request.subject
  #
  def order_request(requests_support_request)
    @requests_support_request = requests_support_request
    @greeting = "Hi"
    @url = path_url

    mail :to => @requests_support_request.email, :subject => 'Solicitud registrada: ' + @requests_support_request.num_sequence

  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.order_budget.subject
  #
  def order_budget()
   
    @greeting = "Hi"

    mail :to => "docs1006@prodigy.net.mx", :subject => 'Pragmatic Store Order Confirmation'
  end

  def snd_email(user, mensaje)
    @user = user
    email_with_name = "#{@user.name} <#{@user.email}>"
    mail(:to => email_with_name,
         :subject => mensaje)
  end

  #Envío de Correo con instrucciones
  def instructions(pm_user,pm_request_id,pm_budget_id, pm_instruction)

    @requests_support_request = RequestsAdministration::SupportRequest.find(pm_request_id)
    @budgets_budget = Budgets::Budget.find(pm_budget_id)
    @budgets_budget.add_instruc = pm_instruction

    @url = path_url
    user_ubication_id = Administration::UserSession.find.record.attributes['ubication_id']
    user_id = Administration::UserSession.find.record.attributes['id']
    req_admin_id = @requests_support_request.id

#    @users = involved(req_admin_id,user_id,user_ubication_id)

#    lv_sql = 'SELECT DISTINCT dl.user_id,us.name,us.ubication_id, us.email
#                FROM request_delegations dl, administration_users us
#               WHERE dl.user_id = us.id
#                 AND dl.support_request_id='+ req_admin_id.to_s() +
#                 ' AND dl.user_id <> '+ user_id.to_s() +
#                 ' AND us.ubication_id ='+user_ubication_id.to_s()+
#               ' UNION
#              SELECT DISTINCT dl.helper_id user_id,us.name,us.ubication_id,us.email
#                FROM request_delegations dl, administration_users us
#               WHERE dl.helper_id = us.id
#                 AND dl.support_request_id='+req_admin_id.to_s()+
#                 ' AND dl.helper_id <> '+user_id.to_s() +
#                 ' AND us.ubication_id ='+user_ubication_id.to_s()
#    @users = Administration::User.find_by_sql(lv_sql)

    
      @user = pm_user
      email_with_name = "#{@user.name} <#{@user.email}>"      
      mail(:to => email_with_name, :subject => 'Instrucciones: ' + @requests_support_request.num_sequence)
  end

end
