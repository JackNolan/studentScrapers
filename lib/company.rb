class Company
	@@db = SQLite3::Database.open('db/masterJob.db')

	def self.count
		@all_companies.length
	end
	def self.all
		@all_companies ||= []
	end
	def self.save_all
		Company.all.each{|e| e.save}
		Job.count.to_s + " companies saved"
	end
	def self.get_company(company)
			Company.all.select{|prev_comp| prev_comp.name == company}.first || Company.new.tap {|e| e.name = comp;e.add_location loc }
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
	def get_id
		@id = @@db.execute("select id from companies where name = ?",
			[@name]).first
		@id 
	end
	def id 
		@@db.execute("SELECT id FROM companies WHERE name = (?)",@name)
	end
end