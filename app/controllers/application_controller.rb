class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end


require 'net/http'
require 'rexml/document'
require 'pry'
# require 'nokogiri'
# require 'open-uri'

# get the words from the

puts "What word to look up? Can enter multiple comma-delimited "

# make the words as a string into an array containing each word
input_words = gets

words = input_words.split(/,/).map { |w| w.strip }

# WHY ISN'T IT MAKING IT AN ARRAY WITH MULTIPLE WORDS?

	
# puts words


# form the API URL for each of the words, for each words as word
# baseURL + word + key
# http://www.dictionaryapi.com/api/v1/references/collegiate/xml/titrate?key=11917c67-d3c9-4ec9-8047-c53587ef01c6

BaseUrl = "http://www.dictionaryapi.com/api/v1/references/collegiate/xml/"
	key = "?key=11917c67-d3c9-4ec9-8047-c53587ef01c6"

words.each do |word|
  
	url = BaseUrl + word + key



	xml_data = Net::HTTP.get_response(URI.parse(url)).body

	# extract event information
	doc = REXML::Document.new(xml_data)
	wordz = []
	defs = []
	doc.elements.each('entry_list/entry/ew') do |ele|	   				
   		wordz << ele.text
	end	

	doc.elements.each('entry_list/entry/def/dt') do |ele|   		
   		defs << ele.text
	end

	# print all events
	wordz.each_with_index do |wordz, idx|
   print "#{wordz} => #{defs[idx]}\n"
	end
end





	exit
	# doc = Nokogiri::HTML(open(xml_data))
	# puts doc
	


	# puts xml_data
# end

=begin


#receive the data
xml_data = Net::HTTP.get_response(URI.parse(url)).body

# list the data to test
# puts xml_data


# extract only the WORD key and DEFINITION key of the returned object


# show the value for the WORD and value for the DEF 
# #{word} : #{DEF}

=end
