DROP TABLE IF EXISTS cities;

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