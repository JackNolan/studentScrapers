class Company
	@@db = SQLite3::Database.open('masterJob.db')

	def self.count
		@all_companies.length
	end
	def self.all
		@all_companies ||= []
	end
	def self.save_all
		Company.all.each{|e| e.save}
	end
	attr_accessor :name,:locations,:jobs
	def initialize
		@locations = []
		@jobs = []
		Company.all << self
	end
	def add_job(job)
		@jobs << job
	end
	def add_location(location)
		@locations << location
	end
	def save
		@@db = db.execute("INSERT INTO companies ( name,locations,jobs)
					VALUES (?,?,?)", [@name,@locations,@jobs])
	end
	
end