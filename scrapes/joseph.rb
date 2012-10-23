require_relative "../lib/require"

root_url = "http://jobs.37signals.com"

# puts "Enter keywords for your job search (no commas)"
# keywords = gets.chomp.split(" ").join("+")

search_url = root_url+"/jobs/search?term=rails"

search_results = Nokogiri::HTML(open(search_url))
result_records = search_results.css("div#category-2 li a")
result_records.each do |r|
	unless r == result_records.last
		posting_url = root_url+r["href"]
		puts posting_url

		company = r.css("span.company").inner_text
		puts company

		location = r.css("span.city").inner_text
		puts location

		title = r.css("span.title").inner_text
		puts title

		posting_date = r.css("span.date").inner_text+", "+DateTime.now.year.to_s
		puts posting_date

		listing = Nokogiri::HTML(open(posting_url))

		# listing.css("div.apply a")[0].inner_text.gsub(/@(\S+)/)
		# puts $1
		website = 
			if listing.css("div.listing-header-container a")[0]
				listing.css("div.listing-header-container a")[0]["href"]
			else
				""
			end
		puts website

		description = listing.css("div.listing-container").inner_text
		puts description

		where_to_apply = 
		
			if listing.css("div.apply a").empty?
				"#"
			else
				listing.css("div.apply a")[0].inner_text
			end
		puts where_to_apply
		puts "-------------------------------"
		Job.new(title,location,nil,company,website,description)
	end
end
Job.save_all
Company.save_all