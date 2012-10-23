#!/bin/bash
touch masterJob.db
sqlite3 masterJob.db < schema.sql