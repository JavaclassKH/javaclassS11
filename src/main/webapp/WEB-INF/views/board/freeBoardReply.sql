CREATE TABLE freeBoardreply (
	idx INT NOT NULL AUTO_INCREMENT,
	boardIdx INT NOT NULL,
	mid VARCHAR(50) NOT NULL,
	nickName VARCHAR(60) NOT NULL,
	content TEXT NOT NULL,
	PRIMARY KEY (idx),
  FOREIGN KEY (mid) REFERENCES memberss (mid)
);



























