# Specify gemfile Location and general variables
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
puts ENV['BUNDLE_GEMFILE']

# Gems
require 'rubygems'
require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])
require 'pathname'
require 'pg'
require 'active_record'
require 'sinatra'
require 'sinatra/cookies'
require 'byebug'
require 'bcrypt'

# Set APP_ROOT
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

# Connect postgres database
require APP_ROOT.join('config', 'database')

# Sinatra configuration
set :public_folder, File.join(APP_ROOT, "public")
set :views, File.join(APP_ROOT, "views")
set :erb, layout: :'application'
enable :sessions # enable sessions
set :session_secret, "its a secret"  #use with shotgun

# Load files
Dir[APP_ROOT.join('controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('helpers', '*.rb')].each { |file| require file }
