
CREATE OR REPLACE FUNCTION maintain_updated_at()
RETURNS TRIGGER AS $$
BEGIN
   NEW.updated_at = now();
   RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TABLE cities (
  id serial primary key,
  name text not null,
  postcode text not null,
  created_at timestamp not null default current_timestamp,
  updated_at timestamp not null default current_timestamp);

CREATE trigger cities_updated_at before UPDATE ON cities FOR each row EXECUTE PROCEDURE maintain_updated_at();

CREATE TABLE Teams (
  id SERIAL PRIMARY KEY,
  name TEXT,
  practice_night TEXT
);

CREATE TABLE MembershipTypes (
   type TEXT PRIMARY KEY,
   fee INT
);

CREATE TABLE Members (
  id SERIAL PRIMARY KEY,
  lastname TEXT,
  firstname TEXT,
  phone TEXT,
  handicap INT,
  join_date DATE NOT NULL DEFAULT current_date,
  gender VARCHAR(1),
  team_id INT REFERENCES Teams(id),
  membership_type TEXT REFERENCES MembershipTypes(type),
  coach INT REFERENCES Members(id)
);

ALTER TABLE Teams ADD COLUMN manager_id INT REFERENCES Members(id);

CREATE TABLE TournamentTypes (
  type TEXT PRIMARY KEY
);

CREATE TABLE Tournaments (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  type TEXT REFERENCES TournamentTypes(type)
);

CREATE TABLE Entries (
  id SERIAL PRIMARY KEY,
  year TEXT,
  member_id INT REFERENCES Members(id),
  tour_id INT REFERENCES Tournaments(id)
);

CREATE TABLE Areas (
  name TEXT PRIMARY KEY
);

CREATE TABLE Incomes (
  id SERIAL PRIMARY KEY,
  area TEXT REFERENCES Areas(name),
  month INT,
  income INTEGER
);