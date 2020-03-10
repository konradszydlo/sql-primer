#!/usr/bin/env bash

### Start DB container

### In dev, remove data folder so schema and fixtures files can be run.
sudo rm -rf ./data

sudo docker-compose -p sql_primer up -d