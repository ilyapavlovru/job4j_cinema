CREATE TABLE account
(
    id       SERIAL PRIMARY KEY,
    username VARCHAR NOT NULL,
    phone    VARCHAR NOT NULL UNIQUE
);

CREATE TABLE ticket
(
    id         SERIAL PRIMARY KEY,
    session_id INT NOT NULL,
    row        INT NOT NULL,
    cell       INT NOT NULL,
    account_id INT NOT NULL REFERENCES account
);
ALTER TABLE ticket ADD CONSTRAINT constraint_unique_ticket UNIQUE (session_id, row, cell);