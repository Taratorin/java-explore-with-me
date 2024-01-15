CREATE TABLE IF NOT EXISTS apps (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  name VARCHAR(150) NOT NULL,
  CONSTRAINT pk_aps PRIMARY KEY (id),
  CONSTRAINT UQ_APPS_NAME UNIQUE(name)
);

CREATE TABLE IF NOT EXISTS endpoint_hit (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  app_id BIGINT NOT NULL,
  uri VARCHAR(2048) NOT NULL,
  ip VARCHAR(15) NOT NULL,
  ts TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  CONSTRAINT pk_endpoint_hit PRIMARY KEY (id),
  CONSTRAINT FK_ENDPOINT_HIT_ON_APP FOREIGN KEY (app_id) REFERENCES apps (id)
);