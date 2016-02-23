require 'sinatra'
require 'i18n'
require 'better_errors' if development?

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end




#Configuracion de email
post '/:locale/archievingsubcription' do
  require 'pony'

  from = "subcribe@archieving.com"
  subject = "Archieving suscription"

  Pony.mail(
      :from => from,
      :to => 'lovera@irstrat.com',
      :headers => { 'Content-Type' => 'text/html' },
      :body => erb(:"en/generales/mail"),
      :via => :smtp,
      :via_options => {
          :address              => 'smtp.mailgun.org',
          :port                 => '587',
          :enable_starttls_auto => true,
          :user_name            => 'postmaster@irstrat.com',
          :password             => '5ptmod-dfz40',
          :authentication       => :plain,
          :domain               => "irstrat.com"
      })
  redirect '/'
end



# Globales

get '/' do
  erb (I18n.locale.to_s + '/index').to_sym
end

get '/es' do
  erb 'es/index'.to_sym
end



                                                              # HELPER
