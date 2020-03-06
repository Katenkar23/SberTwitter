#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username postgres --dbname postgres <<-EOSQL
    CREATE ROLE feed_admin WITH SUPERUSER CREATEDB LOGIN PASSWORD 'qwerty123456' VALID UNTIL '2100-03-17';
    CREATE TABLESPACE feed_cfg_data OWNER feed_admin LOCATION '/var/lib/postgresql/data';
    CREATE DATABASE feed_db WITH OWNER = feed_admin ENCODING = 'UTF8' TABLESPACE = feed_cfg_data CONNECTION LIMIT = -1;
EOSQL
psql -v ON_ERROR_STOP=1 --username feed_admin --dbname feed_db <<-EOSQL
    CREATE SCHEMA feed_cfg AUTHORIZATION feed_admin;
    ALTER ROLE feed_admin set search_path = feed_cfg,public;
EOSQL
psql -v ON_ERROR_STOP=1 --username feed_admin --dbname feed_db <<-EOSQL
  CREATE TABLE FEED(
  ownerId BIGINT NOT NULL,
  userId BIGINT NOT NULL,
  twittId BIGINT NOT NULL,
  content TEXT,
  date TIMESTAMP,
  PRIMARY KEY(ownerId,userId,twittId)
) TABLESPACE feed_cfg_data;
EOSQL
