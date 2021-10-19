CREATE TABLE IF NOT EXISTS Documents (
	name TEXT,
	scan_date INT,
	content TEXT,
	description TEXT,
	file_ext TEXT
);

CREATE TABLE IF NOT EXISTS Appendicies (
    parent_id INT NOT NULL,
    content TEXT
);

CREATE TABLE IF NOT EXISTS Tags (
	name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Doc_Tag (
    doc_id INT NOT NULL,
    tag_id INT NOT NULL
);

-- Default entries
INSERT INTO Tags VALUES ("Rechnung"), ("Brief"), ("Mahnung"), ("Informationen"), ("Stadt"), ("Abrechnung");
