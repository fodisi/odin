# @Author: fodisi

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


#!/usr/bin/env python3


import json

import psycopg2


class DBManager(object):
    """Responsible for managing connections to a specific PostgreSQL database.

    Attributes:
        host (str): IP address of the server where the database is installed.
        database (str): Database name.
        user (str): user's name to connect to database.
        password (str): user's password to connect to database.
        port (str): port used to connect to the database.

    """

    def __init__(self, conn_config_file: str) -> None:
        """Default constructor. Sets DB connection settings based on a configuration file.

        Args:
            conn_config_file (str): the configuration file path and name to load the 
            database connection settings from. The configuration file content must be
            a JSON object with the following format:
            {
                "host": "localhost",
                "dbname": "thedatabase",
                "user": "theuser",
                "password": "secret_password",
                "port": "port_number"
            }

        """
        with open(conn_config_file) as config_file:
            config = json.load(config_file)
            self.host = config['host']
            self.database = config['database']
            self.user = config['user']
            self.password = config['password']
            self.port = int(config['port'])

    def connect(self) -> psycopg2.extensions.connection:
        """Creates a connection to the database.

        Returns:
            psycopg2.extensions.connection: a connection object to a specific database.

        """
        return psycopg2.connect(
            host=self.host,
            dbname=self.database,
            user=self.user,
            password=self.password,
            port=self.port
        )
