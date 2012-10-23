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
		@@db.execute("INSERT INTO companies ( name)
					VALUES (?)", [@name])
	end
	def id 
		@@db.execute("SELECT id FROM companies WHERE name = (?)",@name)
	end
end