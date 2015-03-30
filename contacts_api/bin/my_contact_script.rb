require 'addressable/uri'
require 'rest-client'

def all_contacts
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts'
  ).to_s

  puts RestClient.get(url)
end


def create_contact

  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts.json'
  ).to_s

  begin
    puts RestClient.post(url,
    {contact: {name: "donnie darko", email: "frank@rabbit.com", user_id: 1}})
  rescue RestClient::UnprocessableEntity => e
    puts e.message
  end

  puts RestClient.get(url)
end


def show_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts/1.json'
  ).to_s

  puts RestClient.get(url)

end

def update_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts/2'
  ).to_s

  puts RestClient.put(url, contact: {name: "Elmo", email: "elmo@sesamestreet.com"})
end

def destroy_contact
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/contacts/3'
  ).to_s

  puts RestClient.delete(url)
end

all_contacts
