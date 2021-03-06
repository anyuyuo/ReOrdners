CREATE TABLE IF NOT EXISTS Documents (
	name TEXT,
	scan_date INT,
	content TEXT,
	description TEXT,
	file_ext TEXT,
	file_orig_name TEXT
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


-- new schema
-- slowly phasing out the old one
CREATE TABLE IF NOT EXISTS document_new (
	name TEXT,
	creation_date INT,
	parent_img INT
);

CREATE TABLE IF NOT EXISTS image (
	filename TEXT,
	mimetype TEXT,
	content TEXT
);

CREATE TABLE IF NOT EXISTS doc_img (
	doc_id INT,
	image_id INT
);

-- Default entries
INSERT INTO Tags VALUES ("Rechnung"), ("Brief"), ("Mahnung"), ("Informationen"), ("Stadt"), ("Abrechnung");