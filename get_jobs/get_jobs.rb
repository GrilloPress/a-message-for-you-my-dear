require 'rubygems'
require 'bundler/setup'
require 'nokogiri'
require 'open-uri'

JOBS_URL = "http://www.jobs.nhs.uk/extsearch?client_id=121486&resonly=1&max_result=100"
page = Nokogiri::HTML(open(JOBS_URL))

page = page.css('div.vacancy')
page.each do |v|
  
  # make links absolute
  v.css('h2 a').each do |x|
    x["href"] = "http://www.nhs.jobs#{x['href']}"
  end
  
end

puts page