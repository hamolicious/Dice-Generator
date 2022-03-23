require 'sinatra'
require_relative './utils'

# setup filesystem
if !File.exists?(get_assets_path())
    Dir.mkdir(get_assets_path())
end

# setup sinatra
Dir.chdir(__dir__)
set :root,  File.dirname(__dir__)
set :views, Proc.new { File.join(__dir__, 'views') }
set :public_folder, get_assets_path()

# import routes
require_relative './routes/dice.svg'
require_relative './routes/docs/dice.svg'


