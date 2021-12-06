require 'rubygems'
require 'pony'
require 'sinatra'
require 'sinatra/base'

get '/' do
        
    "hello worldsaasdas" 
            
    end

post '/' do
    Pony.mail(:to => ENV['naburoky@gmail.com'],
                :from => "naburoky@gmail.com",
                :subject =>  "naburoasdasdasd",
                :body =>  "naburoky@gmail.com" +" wrote:\n" + "naburoasdasdasd",
                :via => :smtp,
                :via_options => {
                    :address              => 'smtp.gmail.com',
                    :port                 => '587',
                    :enable_starttls_auto => true,
                    :user_name                 => ENV['naburoky@gmail.com'],
                    :password             => ENV['N@bB@t10249905'],
                    :authentication       => :plain, 
                    :domain               => "localhost.localdomain" 
                }) 
    end
