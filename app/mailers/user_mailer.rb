class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    @greeting = t ".hi"
    mail to: user.email, subject: t(".acc_activation")
  end

  def password_reset
    @greeting = "Hi"
    mail to: "to@example.org"
  end
end
