class Notifier < ActionMailer::Base
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


  #Envío de Correo con instrucciones
  def instructions(requests_support_request,budgets_budget)
    @requests_support_request = requests_support_request
    @budgets_budget = budgets_budget
    @url = path_url
    user_ubication_id = Administration::UserSession.find.record.attributes['ubication_id']
    user_id = Administration::UserSession.find.record.attributes['id']
    req_admin_id = @requests_support_request.id
    lv_sql = 'SELECT DISTINCT dl.user_id,us.name,us.ubication_id, us.email
                FROM request_delegations dl, administration_users us
               WHERE dl.user_id = us.id
                 AND dl.support_request_id='+ req_admin_id.to_s() +
                 ' AND dl.user_id <> '+ user_id.to_s() +
                 ' AND us.ubication_id ='+user_ubication_id.to_s()+
               ' UNION
              SELECT DISTINCT dl.helper_id user_id,us.name,us.ubication_id,us.email
                FROM request_delegations dl, administration_users us
               WHERE dl.helper_id = us.id
                 AND dl.support_request_id='+req_admin_id.to_s()+
                 ' AND dl.helper_id <> '+user_id.to_s() +
                 ' AND us.ubication_id ='+user_ubication_id.to_s()
    @users = Administration::User.find_by_sql(lv_sql)

    # Enviar a cada uno de los involucrados
    @users.each do |users|      
      mail :to => users.attributes['email'], :subject => 'Instrucciones: ' + @requests_support_request.num_sequence
    end
    

  end

end
