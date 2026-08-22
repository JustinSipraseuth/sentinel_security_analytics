/*
organizations
	organization_id
	organization_name
	industry
	subscription_tier
	created_at
*/

CREATE TABLE organizations(
	organization_id INT PRIMARY KEY,
	organization_name VARCHAR(100) NOT NULL, 
	industry TEXT NOT NULL,
	subscription_tier VARCHAR (50), --I'm unsure what the tiers are called, so this is my current best guess.
	created_at DATE DEFAULT CURRENT_DATE
);

/*
users
	user_id
	organization_id
	username
	department
	job_title
	is_active
*/

CREATE TABLE users(
	user_id INT PRIMARY KEY,
	organization_id INT,
	FOREIGN KEY (organization_id) REFERENCES organizations(organization_id),
	username VARCHAR(50) NOT NULL UNIQUE, --EB-007: I think it would get messy if there were duplicate or null usernames.
	department VARCHAR(50),
	job_title VARCHAR(100),
	is_active BOOL --I assume this is whether or not the user is an active user of this account.
);

/*
devices
	device_id
	organization_id
	device_type
	operating_system
	managed_by_it
*/

CREATE TABLE devices(
	device_id INT PRIMARY KEY,
	organization_id INT,
	FOREIGN KEY (organization_id) REFERENCES organizations(organization_id),
	device_type varchar(50), --I'm not sure what this is. Computer, phone, tablet?
	operating_system varchar(50), 
		--I assume this is the name of the OS, like Windows 11, and not a unique ID?
	managed_by_it BOOL 
		--I'm unsure what this means. Basically, "is it a device handled by IT of an org?"
);

/*
authentication_events
	event_id
	event_timestamp
	user_id
	device_id
	ip_address
	application_name
	authentication_method
	authentication_result
*/
CREATE TABLE authentication_events(
	event_id INT PRIMARY KEY,
	event_timestamp TIMESTAMPTZ,
	user_id INT,
	device_id INT,
	FOREIGN KEY (user_id) REFERENCES users(user_id),
	FOREIGN KEY (device_id) REFERENCES devices(device_id),
	ip_address TEXT,
	application_name TEXT NOT NULL, --Very unsure what this is at all, so TEXT is the default EB-007: If it's a name, no null would be best.
	authentication_method TEXT,
	authentication_result TEXT
);


