require 'sinatra'
require 'i18n'
require 'better_errors' if development?

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end





# Globales

get '/' do
  erb (I18n.locale.to_s + '/index').to_sym
end



                                                              # HELPER
