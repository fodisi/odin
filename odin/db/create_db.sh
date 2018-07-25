# MIT License

# Copyright (c) 2018 fodisi - https://github.com/fodisi/

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.



#!/usr/bin/env bash


# Creates a system user with no home directory, no access to shell and unable to login.
# Username and user group will have the same name.
sudo adduser odin_admin --system --group --no-create-home --shell=/bin/false

# Creates db admin role, database and grants permisson to db_admin. Revokes permission from other users.
# sudo su - postgres -c 'psql -c "CREATE ROLE odin_admin WITH ENCRYPTED PASSWORD \''123456\'';"'
# sudo -H su - postgres -c 'psql -c "CREATE ROLE odin_admin WITH ENCRYPTED PASSWORD \''123456\'';"'

sudo su - postgres -c 'psql -c "CREATE ROLE odin_admin WITH LOGIN ENCRYPTED PASSWORD '\''123456'\'';"'

# sudo -H -u postgres psql -c '"CREATE ROLE odin_admin WITH ENCRYPTED PASSWORD \''123456\'';"'
sudo su - postgres -c 'psql -c "CREATE DATABASE odin WITH OWNER odin_admin;"'
sudo su - postgres -c 'psql -c "REVOKE CONNECT ON DATABASE odin FROM PUBLIC;"'
sudo su - postgres -c 'psql -c "GRANT ALL ON DATABASE odin TO odin_admin;"'


# # Grants database schema and grants privileges to db_admin. Revokes permission from other users.
sudo -H -u postgres psql odin -c "CREATE SCHEMA catalog AUTHORIZATION odin_admin;"
sudo -H -u postgres psql odin -c "REVOKE ALL ON SCHEMA catalog FROM public;"
sudo -H -u postgres psql odin -c "GRANT ALL PRIVILEGES ON SCHEMA catalog TO odin_admin;"
sudo -H -u postgres psql odin -c "ALTER DEFAULT PRIVILEGES IN SCHEMA catalog GRANT ALL PRIVILEGES ON TABLES TO odin_admin;"
# sudo -H -u postgres psql odin -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA catalog TO odin_admin;"



# Creates application role
sudo su - postgres -c 'psql -c "CREATE ROLE odin_app NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;"'
sudo su - postgres -c 'psql -c "ALTER ROLE odin_app WITH LOGIN ENCRYPTED PASSWORD '\''123456'\'';"'

sudo -H -u postgres psql odin -c "GRANT CONNECT ON DATABASE odin TO odin_app;"
sudo -H -u postgres psql odin -c "GRANT USAGE ON SCHEMA catalog TO odin_app;"
sudo -H -u postgres psql odin -c "ALTER DEFAULT PRIVILEGES IN SCHEMA catalog GRANT ALL PRIVILEGES ON TABLES TO odin_app;"
# sudo -H -u postgres psql odin -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA catalog TO odin_app;"

# Creates external service role
sudo su - postgres -c 'psql -c "CREATE ROLE odin_service_catalog NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;"'
sudo su - postgres -c 'psql -c "ALTER ROLE odin_service_catalog WITH LOGIN ENCRYPTED PASSWORD '\''123456'\'';"'

sudo -H -u postgres psql odin -c "GRANT CONNECT ON DATABASE odin TO odin_service_catalog;"
sudo -H -u postgres psql odin -c "GRANT USAGE ON SCHEMA catalog TO odin_service_catalog;"
sudo -H -u postgres psql odin -c "ALTER DEFAULT PRIVILEGES IN SCHEMA catalog GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO odin_service_catalog;"
# sudo -H -u postgres psql odin -c "GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER  ON ALL TABLES IN SCHEMA catalog TO odin_service_catalog;"

sudo -H -u postgres psql odin -c "CREATE TABLE catalog.mytest (name varchar (25) NOT NULL);"
sudo -H -u postgres psql odin -c "SELECT * FROM catalog.mytest;"

sudo -H -u postgres psql odin -c "CREATE TABLE catalog.mytest2 (name varchar (25) NOT NULL);"
sudo -H -u postgres psql odin -c "SELECT * FROM catalog.mytest2;"


# sudo -H -u odin_admin -c 'psql odin -c "CREATE SCHEMA catalog AUTHORIZATION odin_admin;"'
# sudo -H -u odin_admin -c 'psql odin -c "GRANT ALL PRIVILEGES ON SCHEMA catalog TO odin_admin;"'
# sudo -H -u odin_admin -c 'psql odin -c "REVOKE ALL ON SCHEMA catalog FROM public;"'

# # Grants permisson on database schema to application role
# sudo -H -u odin_admin -c 'psql odin -c "GRANT USAGE ON SCHEMA catalog TO odin_app;"'
# sudo -H -u odin_admin -c 'psql odin -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA catalog TO odin_app;"'

# # Grants permisson on database schema to external service role
# sudo -H -u odin_admin -c 'psql odin -c "GRANT USAGE ON SCHEMA catalog TO odin_service_catalog;"'
# sudo -H -u odin_admin -c 'psql odin -c "GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER  ON ALL TABLES IN SCHEMA catalog TO odin_service_catalog;"'

# # Used for testing only
# sudo -H -u odin_admin -c 'psql odin -c "CREATE TABLE catalog.mytest (name varchar (25) NOT NULL);"'
# sudo -H -u odin_admin -c 'psql odin -c "SELECT * FROM catalog.mytest;"'

# 





# sudo -u postgres psql

# psql

# CREATE USER odin_admin WITH LOGIN PASSWORD '123456';  # change password for deployment
# CREATE USER odin_app WITH LOGIN PASSWORD '123456'; # change password for deployment
# CREATE USER odin_service_catalog WITH LOGIN PASSWORD '123456'; # change password for deployment
# CREATE DATABASE odin WITH OWNER odin_admin;
# GRANT ALL ON DATABASE odin TO odin_admin;

# sudo -H -u odin bash -c 'echo "I am $USER, with uid $UID"' 
# sudo su - odin bash -c 'echo "I am $USER, with uid $UID"' 

# The relevant parts of man sudo:

# -H   The -H (HOME) option requests that the security policy set
#      the HOME environment variable to the home directory of the
#      target user (root by default) as specified by the password
#      database.  Depending on the policy, this may be the default
#      behavior.
# -u user     The -u (user) option causes sudo to run the specified
#       command as a user other than root.  To specify a uid
#       instead of a user name, use #uid.  When running commands as
#       a uid, many shells require that the '#' be escaped with a
#       backslash ('\').  Security policies may restrict uids to
#       those listed in the password database.  The sudoers policy
#       allows uids that are not in the password database as long
#       as the targetpw option is not set.  Other security policies
#       may not support this.

# sudo -H -u odin
# sudo su - postgres -c 'psql -c "CREATE ROLE odin_admin WITH ENCRYPTED PASSWORD \''123456\'';"'





# GRANT CONNECT ON DATABASE odin TO odin_admin;

# quits psql
# \quit

# # Exits from "sudo su - postgres"
# exit

# sudo su - odin_admin

# sudo psql odin

# CREATE SCHEMA catalog AUTHORIZATION odin_admin;

# GRANT ALL PRIVILEGES ON SCHEMA catalog TO odin_admin;
# GRANT ALL PRIVILEGES ON SCHEMA catalog TO odin_app;
# GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA catalog TO odin_service_catalog;
# REVOKE ALL ON SCHEMA catalog FROM public;

# CREATE TABLE catalog.mytest (name varchar (25) NOT NULL);



