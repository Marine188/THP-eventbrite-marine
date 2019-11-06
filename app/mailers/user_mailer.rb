class UserMailer < ApplicationMailer
default from: 'marine@marine.com'

  def welcome_email(user)
    @user = user   #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user

    @url  = 'http://...../login'  #on définit une variable @url qu'on utilisera dans la view d’e-mail

    # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
    mail(to: @user.email, subject: 'Welcome Marine')

  end
  
end
