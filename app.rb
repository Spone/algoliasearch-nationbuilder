require 'rubygems'
require 'sinatra'
require 'http'

before do

  # Parse JSON in body
  if request.body.size > 0
    request.body.rewind
    @params = ActiveSupport::JSON.decode(request.body.read)
  end

end


helpers do
  def valid_token?
    return params['token'] === ENV['NATIONBUILDER_WEBHOOK_TOKEN']
  end

  def check_token
    unless valid_token?
      halt 403, 'Bad token'
    end
  end
end

get '/' do
  "Hello from Sinatra on Heroku!"
end

post '/people/created' do
  check_token
  'People created'
end

post '/people/changed' do
  check_token
  'People changed'
end

post '/people/merged' do
  check_token
  'People merged'
end

post '/people/deleted' do
  check_token
  'People deleted'
end