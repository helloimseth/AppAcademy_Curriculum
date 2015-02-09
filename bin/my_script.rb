require 'addressable/uri'
require 'rest-client'

def all_users
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users'
  ).to_s

  puts RestClient.get(url)
end


def create_user

  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json'
  ).to_s

  begin
    puts RestClient.post(url,
    {user: {name: "donnie darko"}})
  rescue RestClient::UnprocessableEntity => e
    puts e.message
  end

  puts RestClient.get(url)
end


def show_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/1.json'
  ).to_s

  puts RestClient.get(url)

end

def update_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/2'
  ).to_s

  puts RestClient.put(url, user: {name: "SoaringEagle", email: "cougar@appacademy.io"})
end

def destroy_user
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users/3'
  ).to_s

  puts RestClient.delete(url)
end

update_user
