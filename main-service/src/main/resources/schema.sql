--DROP TABLE IF EXISTS bookings, comments, items, requests, users CASCADE;

CREATE TABLE IF NOT EXISTS users (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(512) NOT NULL UNIQUE,
  CONSTRAINT pk_user PRIMARY KEY (id),
  CONSTRAINT uq_users UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS categories (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  name VARCHAR(255) NOT NULL UNIQUE,
  CONSTRAINT pk_categories PRIMARY KEY (id),
  CONSTRAINT uq_categories UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS locations (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  location_lat FLOAT NOT NULL,
  location_lon FLOAT NOT NULL,
  CONSTRAINT pk_locations PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS events (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  category_id BIGINT NOT NULL REFERENCES categories(id),
  initiator_id BIGINT NOT NULL REFERENCES users(id),
  state VARCHAR(20) NOT NULL,
  title VARCHAR(120) NOT NULL,
  annotation VARCHAR(2000) NOT NULL,
  description VARCHAR(7000) NOT NULL,
  eventDate TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  createdOn TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  publishedOn TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  locations_id BIGINT NOT NULL REFERENCES locations(id),
  paid BOOLEAN NOT NULL,
  participantLimit INTEGER NOT NULL,
  confirmedRequests INTEGER,
  requestModeration BOOLEAN NOT NULL,
  views INTEGER,
  CONSTRAINT pk_events PRIMARY KEY (id),
  CONSTRAINT uq_events UNIQUE (title)
);

CREATE TABLE IF NOT EXISTS participation_requests (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  created TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  event_id BIGINT NOT NULL REFERENCES events(id),
  requester_id BIGINT NOT NULL REFERENCES users(id),
  status VARCHAR(20) NOT NULL,
  CONSTRAINT pk_participation_requests PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS compilations (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  event_id BIGINT NOT NULL REFERENCES events(id),
  pinned BOOLEAN NOT NULL,
  title VARCHAR(50) NOT NULL,
  CONSTRAINT pk_compilations PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS events_compilation (
  compilation_id BIGINT NOT NULL REFERENCES compilations(id),
  event_id BIGINT NOT NULL REFERENCES events(id)
);