

require 'sinatra'

set :port, 5555
set :public_folder, './'

get '/' do
  "hello"
end
