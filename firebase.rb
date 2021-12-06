require 'rubygems'
require 'sinatra'
require 'firebase'
require 'json'
require 'googleauth'
require 'httpclient'



base_uri = 'https://ejemploapi-333203-default-rtdb.firebaseio.com/'

private_key_json_string = File.open('keyFire.json').read
firebase = Firebase::Client.new(base_uri, private_key_json_string)

get '/get' do
    response = firebase.get("https://ejemploapi-333203-default-rtdb.firebaseio.com/session")
    return response.raw_body
  end

post '/post/?' do
  response = firebase.push("session", {
    :name => params["user"],
    :created => Firebase::ServerValue::TIMESTAMP,
    :token => "xddd"
  })
  return response.raw_body
  end
put '/put/' do 

  end

delete '/delete/' do
  end