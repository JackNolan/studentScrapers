class Company
	@@db = SQLite3::Database.open('db/masterJob.db')
	# def self.boot_up
	# 	@@db.results_as_hash = true
	# 	@all_companies = @@db.execute("select * from companies").map { |e|  Company.new(e["name"],e["id"])}
	# 	puts @all_companies
	# 	@@db.results_as_hash = false
	# end
	def self.save_all
		@all_companies.each {|e| e.save}
		@all_companies.length.to_s+ " companies saved"
	end
	def self.all
		@all_companies ||= []
	end
	def self.get_company(company)
			Company.all.select{|prev_comp| prev_comp.name == company}.first || Company.new(company)
	end
	attr_accessor :name,:locations,:jobs
	def initialize(name,database_id=nil)
		@name = name
		@locations = []
		@jobs = []
		@id = database_id
		Company.all << self
	end
	def add_job(job)
		@jobs << job
		@locations << job.location
	end
	def id 
		@id ||= get_id
	end
	def save
		@@db.execute("INSERT INTO companies ( name)
					VALUES (?)", [@name])
	end
	private
	def get_id
		@id = @@db.execute("SELECT id FROM companies WHERE name = (?)",@name).first
		save
		@id
	end

end