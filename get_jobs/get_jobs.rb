require 'rubygems'
require 'bundler/setup'
require 'nokogiri'
require 'open-uri'

JOBS_URL = "http://www.jobs.nhs.uk/extsearch?client_id=121486&resonly=1&max_result=100"
page = Nokogiri::HTML(open(JOBS_URL))

# Grab all of the job vacancies then transform inside the block
page = page.css('div.vacancy')

page.each do |v|
  
  v['class'] = "well #{v['class']}"
  
  # make links absolute
  v.css('a').each do |x|
    x["href"] = "http://www.nhs.jobs#{x['href']}"
  end
  
  # Remove job basket
  v.css('.jobBasket').each do |x|
    x.remove
  end
  
  # Remove additional reference to STH
  v.css('p.agency').each do |x|
    x.remove
  end
  
  # Add row to inner summary so that the left and right columns can be bootstrap-ified
  v.css('.vacancy-summary').each do |x|
    x['class']="row #{ x['class']}"
  end
  
  v.css('.left').each do |x|
    x['class']="col-md-6 #{ x['class'] }"
  end
  
  v.css('.right').each do |x|
    x['class']="col-md-6 #{ x['class'] }"
  end
  
  
  # # # # # # # # # # # # # # # # # # # # # #
  #  Append classes for easy jQuery search  #
  # # # # # # # # # # # # # # # # # # # # # #
  
  # Contract type

  if v.at_css("dd:contains('Permanent')")
    v['class'] = "permanent #{v['class']}"
  end
  
  if v.at_css("dd:contains('Students')")
    v['class'] = "students #{v['class']}"
  end
  
  if v.at_css("dd:contains('Fixed term')")
    v['class'] = "fixed-term #{v['class']}"
  end
  
  if v.at_css("dd:contains('Voluntary')")
    v['class'] = "voluntary #{v['class']}"
  end
  
  if v.at_css("dd:contains('Apprenticeship')")
    v['class'] = "apprenticeship #{v['class']}"
  end
  
  # Staff groups
  
  if v.at_css("dd:contains('Additional Professional Scientific & Technical')")
    v['class'] = "additional-professional #{v['class']}"
  end
  
  if v.at_css("dd:contains('Administrative & Clerical')")
    v['class'] = "administrative-clerical #{v['class']}"
  end
  
  if v.at_css("dd:contains('Allied Health Professionals')")
    v['class'] = "allied-health #{v['class']}"
  end
  
  if v.at_css("dd:contains('Additional Clinical Services')")
    v['class'] = "additional-clinical #{v['class']}"
  end
  
  if v.at_css("dd:contains('Estates & Ancillary')")
    v['class'] = "estates-ancillary #{v['class']}"
  end
  
  if v.at_css("dd:contains('Healthcare Scientists')")
    v['class'] = "healthcare-scientists #{v['class']}"
  end
  
  if v.at_css("dd:contains('Medical & Dental')")
    v['class'] = "medical-dental #{v['class']}"
  end
  
  if v.at_css("dd:contains('Nursing & Midwifery')")
    v['class'] = "nursing-midwifery #{v['class']}"
  end

end 

# create or overwrite a file called out.html with the contents of page
File.open("out.html", "w") {|f| f.write(page) }