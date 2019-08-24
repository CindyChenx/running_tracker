ENV['SINATRA_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

configure :development do    
    set :database, 'sqlite3:db/database.db'
end

if ENV['SINATRA_ENV'] == 'development'
    require_relative '../secrets.rb'
end

require_relative '../constants'

require_all 'app'