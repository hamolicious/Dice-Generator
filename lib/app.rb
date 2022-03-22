require 'sinatra'

# setup
Dir.chdir(__dir__)
set :root,  File.dirname(__dir__)
set :views, Proc.new { File.join(__dir__, 'views') }

require_relative './routes/dice'


