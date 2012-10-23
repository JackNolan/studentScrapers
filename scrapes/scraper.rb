def scraper
rubynow_url = "http://jobs.rubynow.com"
rubynow_doc = Nokogiri::HTML(open(rubynow_url))

rubynow_jobs = rubynow_doc.css("h2 a:first").map {|link| "http://jobs.rubynow.com/#{link['href'].sub!('/', '')}"} #[//*[contains(text(), '/jobs/*')]]
rubynow_jobs.each_with_index do |url, index|
  id = index + 1
  job_post = Nokogiri::HTML(open(url))

  id = id
  post_name = "#{job_post.css('h2#headline').text}"
  url = url
  company_name = "#{job_post.css('h2#headline a').text}"
  location = "#{job_post.css('h3#location').text}"
  description = "#{job_post.css('div#info').text}"
 Job.new(post_name,location,nil,company_name,url,description)

end 


rubyinside_url = "http://ruby.jobamatic.com/a/jbb/find-jobs"
rubyinside_doc = Nokogiri::HTML(open(rubyinside_url))

rubyinside_jobs = rubyinside_doc.css("td.title a.jam_link").slice(0..12).map {|link| "http://ruby.jobamatic.com#{link['href']}"} #[//*[contains(text(), '/jobs/*')]]

rubyinside_jobs.each do |url|
  job_post = Nokogiri::HTML(open(url))

  post_name = "#{job_post.css('h2.jam_headline').text}"
  url = url
  company_name = "#{job_post.css('a.jam_link').text}"
  location = "#{job_post.css('span.location').text}"
  description = "#{job_post.css('div#c_job_description').text}"
  #insert into database
  # sql_insert = 
  # #put the code so I see where it breaks
  # puts sql_insert
   Job.new(post_name,location,nil,company_name,url,description)
end 


###### dup of stackoverflow scraper ######
# stackoverflow_url = "http://careers.stackoverflow.com/jobs?searchTerm=ruby&location=nyc"
# stackoverflow_doc = Nokogiri::HTML(open(stackoverflow_url))

# stackoverflow_jobs = stackoverflow_doc.css("a.title").map {|link| "http://careers.stackoverflow.com#{link['href']}"} 
# puts stackoverflow_jobs

# stackoverflow_jobs.each do |url|
#   job_post = Nokogiri::HTML(open(url))

#   post_name = "#{job_post.css('h1#title').text}"
#   url = url
#   company_name = "#{job_post.css('a.employer').text}"
#   location = "#{job_post.css('span.location').text}"
#   description = "#{job_post.css('div.description').text}"

#   Job.new(post_name,location,nil,company_name,url,description)

# end 
end