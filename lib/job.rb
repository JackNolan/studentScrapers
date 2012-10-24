class Job
	@@db = SQLite3::Database.open('db/masterJob.db')

	def self.count
		@all_jobs.length
	end
	def self.all
		@all_jobs ||= []
	end
	def self.save_all
		Job.all.each{|e| e.save}
		@all_jobs.length.to_s + " jobs saved"
	end
	attr_accessor :title, :location, :salary, :company, :url, :description
	def initialize(title,loc,sal,comp,url,desc)
		@title = title
		@location = loc
		@salary = sal
		@url = url
		@description = desc
		@company = Company.all.select{|prev_comp| prev_comp.name == comp}.first || Company.new(comp)
   	@company.add_job self
   	Job.all << self
	end
	def id
		@id ||= get_id
	end
	def get_id
		@id = @@db.execute("select id from jobs where title = ? and company = ? and url = ?",
			[@title,@company.id,@url])
		puts @id 
	end
	def save
		@@db.execute("INSERT INTO jobs (title, location, salary, url, description)
				VALUES (?,?,?,?,?)", [@title, @location, @salary, @url, @description])
	end
end