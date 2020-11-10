CREATE USER bonita IDENTIFIED BY 'bpm';
CREATE USER business_data IDENTIFIED BY 'bpm';

CREATE DATABASE bonita DEFAULT CHARACTER SET UTF8MB4;
CREATE DATABASE business_data DEFAULT CHARACTER SET UTF8MB4;

GRANT ALL ON bonita.* to bonita;
GRANT ALL ON business_data.* to business_data;

-- From MySQL 8.0, need to grant special XA rights:
GRANT XA_RECOVER_ADMIN ON *.* to bonita, business_data;

FLUSH PRIVILEGES;



