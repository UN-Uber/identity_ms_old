require 'rubygems'
require 'sinatra'
require 'googleauth'
require 'httpclient'
require 'openssl'
require 'jwt'


######
# first we load up the private and public keys that we will use to sign and verify our JWT token
# using RS256 algo
######
set :port,ENV['PORT'] || 8080
set :bind,"0.0.0.0"

signing_key_path = File.expand_path("../app.rsa", __FILE__)
verify_key_path = File.expand_path("../app.rsa.pub", __FILE__)

signing_key = ""
verify_key = ""



File.open(signing_key_path) do |file|
  signing_key = OpenSSL::PKey.read(file)
end

File.open(verify_key_path) do |file|
  verify_key = OpenSSL::PKey.read(file)
end

set :signing_key, signing_key
set :verify_key, verify_key


get '/' do
  @token = ""
  mess = {token:@token}
  return mess.to_json
end
post '/login?' do

  if params["username"] == "username" && params["password"] == "password"

    headers = {
      exp: Time.now.to_i + 60 #expire in 1 min
    }

    @token = JWT.encode({user_id: 123456}, settings.signing_key, "RS256", headers)

    mess = {token:@token}
    return mess.to_json
  else
    @token = "Username/Password failed."
    return mess.to_json
  end
end


get '/logout?'do

    if params["token"].nil?
      mess = {token:"token null"}
      return mess.to_json
    end
    @payload, @header = JWT.decode(params["token"], settings.verify_key, true, { algorithm: 'RS256'} )
    @exp = @header["exp"]

      # check to see if the exp is set (we don't accept forever tokens)
    if @exp.nil?
      mess = {token:"No exp set on JWT token."}
      return mess.to_json
    end

    @exp = Time.at(@exp.to_i)

      # make sure the token hasn't expired
    if Time.now > @exp
      mess = {token:"JWT token expired."}
      return mess.to_json
    end
    begin
      @user_id = @payload["user_id"]
      
      if @user_id.to_s == "123456"
        mess = {token: @user_id.to_s}
        return mess.to_json
        else 
          mess = {token: "rejected token."}
        return mess.to_json
      end
    rescue OpenSSL::PKey::PKeyError, JWT::DecodeError, JWT::VerificationError => e
      mess = {token: "rejected token."}
    ensure 
      mess = {token: "rejected token."}
    end
    return mess.to_json
  end

# fuente https://github.com/nickdufresne/jwt-sinatra-example