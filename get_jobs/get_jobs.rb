require 'rubygems'
require 'bundler/setup'
require 'nokogiri'
require 'open-uri'

JOBS_URL = "http://www.jobs.nhs.uk/extsearch?client_id=121486&resonly=1&max_result=100"
page = Nokogiri::HTML(open(JOBS_URL))

# Grab all of the job vacancies then transform inside the block
page = page.css('div.vacancy')
page.each do |v|
  
  # make links absolute
  v.css('a').each do |x|
    x["href"] = "http://www.nhs.jobs#{x['href']}"
  end
  
  # Remove job basket
  v.css('.jobBasket').each do |x|
    x.remove
  end
  
  v.css('.vacancy-summary').each do |x|
    x['class']="row vacancy-summary"
  end

  
  # x['class']="whatever"
  
  # Add row class to vacancy summary block
  
  # add bootstrap styles within vacancy summary block - left and right col-md-6
end

# create or overwrite a file called out.html with the contents of page
File.open("out.html", "w") {|f| f.write(page) }