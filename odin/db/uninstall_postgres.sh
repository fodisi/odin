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


# stops postgres 10
sudo pg_dropcluster --stop 10 main

# Removes PostgreSQL adapter for the Python programming language.
sudo pip3 uninstall psycopg2-binary

# sudo apt-get --purge remove postgresql postgresql-contrib
sudo apt-get --purge remove postgresql*

# Sometimes uninstall process leaves some traces...
# In such cases, tries to remove files/directories "manually".
sudo rm -rf /etc/postgresql/
sudo rm -rf /etc/postgresql-common/
sudo rm -rf /var/lib/postgresql/
sudo userdel -r postgres
sudo groupdel postgres

# Checks if postgres is still alive
# Try to reload postgres. Should return an error, as confirmation of uninstall process.
# Error should be similar to "Failed to reload postgres.service: Unit postgres.service not found.".
systemctl reload postgres




# /opt/PostgreSQL/10/installer/server/removeshortcuts.sh /opt/PostgreSQL/10
# /etc/init.d postgresql-10 stop
# rm -rf /opt/PostgreSQL
# rm /etc/postgres-reg.ini
# rm -rf /etc/init.d/postgresql-10
# userdel postgres

# if /etc/ld.so.conf exists, edit it and remove /opt/PostgreSQL/8.3/lib
# if present.

# if /etc/ld.so.conf.d exists:

# rm /etc/ld.so.conf.d/postgresql-10.conf 