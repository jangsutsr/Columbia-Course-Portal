CREATE TABLE usr (
    name TEXT NOT NULL,
    passwd TEXT NOT NULL,
    e_mail TEXT NOT NULL,
    PRIMARY KEY (e_mail)
);
CREATE TABLE department (
    id INTEGER NOT NULL,
    name TEXT,
    PRIMARY KEY (id)
);
CREATE TABLE professor (
    id INTEGER NOT NULL,
    name TEXT,
    PRIMARY KEY (id)
);
CREATE TABLE affiliate (
    dept INTEGER NOT NULL,
    prof INTEGER NOT NULL,
    PRIMARY KEY (dept, prof),
    FOREIGN KEY (dept) REFERENCES department (id),
    FOREIGN KEY (prof) REFERENCES professor (id)
);
-- Weak Entity [course] ==> <teach>
CREATE TABLE course (
    prof INTEGER NOT NULL,
    cid INTEGER NOT NULL,
    name TEXT,
    workload REAL,
    star REAL,
    vote_count INTEGER,
    PRIMARY KEY (prof, cid),
    FOREIGN KEY (prof) REFERENCES professor (id)
);
CREATE TABLE take (
    usr TEXT NOT NULL,
    course INTEGER NOT NULL,
    course_prof INTEGER NOT NULL,
    PRIMARY KEY (usr, course, course_prof),
    FOREIGN KEY (usr) REFERENCES usr (e_mail),
    FOREIGN KEY (course, course_prof) REFERENCES course (cid, prof)
);
CREATE TABLE relate (
    course_prof INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    dept INTEGER NOT NULL,
    PRIMARY KEY (course_prof, course_id, dept),
    FOREIGN KEY (dept) REFERENCES department (id),
    FOREIGN KEY (course_prof, course_id) REFERENCES course (prof, cid)
);
-- Weak Entity [document] ==> <upload_to>
CREATE TABLE document (
    did SERIAL,
    usr TEXT NOT NULL,
    cid INTEGER NOT NULL,
    prof INTEGER NOT NULL,
    name TEXT,
    file_location TEXT,
    create_date DATE,
    star REAL,
    vote_count INTEGER,
    report_count INTEGER,
    PRIMARY KEY (did),
    FOREIGN KEY (usr) REFERENCES usr (e_mail),
    FOREIGN KEY (cid, prof) REFERENCES course (cid, prof)
);
-- Weak Entity [document] ==> <write_for>
CREATE TABLE review (
    rid SERIAL,
    usr TEXT NOT NULL,
    cid INTEGER NOT NULL,
    prof INTEGER NOT NULL,
    content TEXT,
    create_date DATE,
    update_date DATE,
    star REAL,
    vote_count INTEGER,
    report_count INTEGER,
	UNIQUE (usr, cid, prof),
    PRIMARY KEY (rid),
    FOREIGN KEY (usr) REFERENCES usr (e_mail),
    FOREIGN KEY (cid, prof) REFERENCES course (cid, prof)
);