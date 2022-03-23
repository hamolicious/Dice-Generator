require 'sinatra'
require_relative File.join(Dir.pwd, 'utils')

get generate_route(__FILE__) do
    erb :gen_dice
end