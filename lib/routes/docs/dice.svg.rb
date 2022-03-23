require 'sinatra'
require_relative '../.././utils'

get generate_route(__FILE__) do
    erb :doc_dice
end