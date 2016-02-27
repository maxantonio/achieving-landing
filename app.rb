require 'sinatra'
require 'sinatra/reloader'
require 'i18n'
require 'better_errors' if development?

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

# Configuracion de idioma
I18n.enforce_available_locales = false
configure do
  I18n.load_path = Dir[File.join(settings.root, 'locales', '*.yml')]
end

# Filtros para el idioma
before '/:locale/*' do
  I18n.locale = (params[:locale].eql?('es') || params[:locale].eql?('en')) ? params[:locale] : :es
end

before '/' do
  I18n.locale = :en
end
before '/es' do
  I18n.locale = :es
end


#Configuracion de email
post '/achievingsubcription' do
  require 'pony'

  from = "subcribe@archieving.com"
  subject = "Archieving suscription"

  Pony.mail(
      :from => from,
      :to => 'lovera@irstrat.com',
      :headers => {'Content-Type' => 'text/html'},
      :body => erb(:"en/generales/mail"),
      :via => :smtp,
      :via_options => {
          :address => 'smtp.mailgun.org',
          :port => '587',
          :enable_starttls_auto => true,
          :user_name => 'postmaster@irstrat.com',
          :password => '5ptmod-dfz40',
          :authentication => :plain,
          :domain => "irstrat.com"
      })
  redirect '/'
end

# Globales

get '/' do
  erb (I18n.locale.to_s + '/index').to_sym
end

get '/:locale' do
  erb (I18n.locale.to_s + '/index').to_sym
end

get '/:locale/7-steps-freelancer' do
  erb (I18n.locale.to_s + '/7-steps-freelancer').to_sym
end

get '/:locale/goal2' do
  erb (I18n.locale.to_s + '/goal2').to_sym
end

get '/:locale/7-steps-freelancer2' do
  @pageTitle = :freelancer
  erb (I18n.locale.to_s + '/7-steps-freelancer2').to_sym, :layout => 'layouts/contenido'.to_sym
end

# HELPER
