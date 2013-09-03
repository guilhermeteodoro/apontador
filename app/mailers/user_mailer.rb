#encoding: UTF-8
class UserMailer < ActionMailer::Base
  default from: "checkerbootcamp@gmail.com"

  def welcome_email(user, manager, pass)
    @user = user
    @temp_pass = pass
    @manager = manager
    @url = "localhost:3000/"
    mail(to: @user.email, subject: 'Bem-vindo ao Checker!')
  end

  def user_update_email(user, changes)
    @user = user
    @changes = changes
    mail(to: @user.email, subject: 'Alteração de Informações')
  end
end
