require 'sinatra'
require 'json'
require 'sinatra/json'

post '/test' do
  data = JSON.parse(request.body.read)
  data.to_json
end

get '/json' do
  json(:foo => 'bar')
end

get '/hello' do
  puts 'Hello world'

  person = PersonResource.new("Per Olsen", 35, "man")
  person.add_link("father", Link.new("http://www.vg.no", "GET"))

  json(:person => person)
end

class Link
  attr_reader :href, :method

  def initialize(href, method)
    @href = href
    @method = method
  end

  def to_json(options)
    {:href => @href, :method => @method}.to_json
  end
end

class Resource
  attr_reader :_links

  def initialize()
    @_links = Array.new()
  end

  def add_link(rel, link)
    @_links << {rel => link}
  end

  def to_json(options)
    {:_links => @_links}.to_json
  end
end

class PersonResource < Resource
  attr_reader :name, :age, :gender

  def initialize(hame, age, gender)
    @name = name
    @age = age
    @gender = gender

    super()
  end

  def to_json(options)
    {:name => @name, :age => @age, :gender => @gender}.to_json
    super(options)
  end
end


