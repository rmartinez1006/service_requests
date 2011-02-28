class Notifier < ActionMailer::Base
  default :from => "rmo1006@gmail.com"

  def path_url
    return '192.168.1.74:3000'
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
end
