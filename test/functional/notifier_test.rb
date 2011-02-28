require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  test "order_request" do
    mail = Notifier.order_request
    assert_equal "Order request", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "order_budget" do
    mail = Notifier.order_budget
    assert_equal "Order budget", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
