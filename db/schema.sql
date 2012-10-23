CREATE TABLE jobs (
	id INTEGER PRIMARY KEY,
	title TEXT, 
	location TEXT, 
	salary TEXT, 
	company INTEGER, 
	url TEXT, 
	description TEXT
);

CREATE TABLE companies (
	id INTEGER PRIMARY KEY,
	name TEXT
);

CREATE TABLE companies_to_job (
	company_id INTEGER,
	job_id INTEGER
);

CREATE TABLE companies_to_locations (
	company_id INTEGER,
	location TEXT
);