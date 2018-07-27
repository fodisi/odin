# #!/usr/bin/env python3


# from abc import ABC, abstractmethod


# """Represents a base ORM (Object Relational Mapper) object."""


# class BaseDAL(ABC):
#     DB_NAME = "bankapp.db"

#     @abstractmethod
#     def prepare_insert(self, obj):
#         pass

#     @abstractmethod
#     def prepare_update(self, obj):
#         pass

#     @abstractmethod
#     def prepare_delete(self, obj):
#         pass

#     @abstractmethod
#     def prepare_select(self, identifier):
#         pass

#     @abstractmethod
#     def prepare_select_all(self):
#         pass

#     @abstractmethod
#     def to_object(self, row):
#         pass

#     def execute_non_query(self, sql_command):
#         # creates a connection to the database
#         with db.connect(self.DB_NAME, check_same_thread=False) as conn:
#             cursor = conn.cursor()
#             """SQLite3 requires that this command be executed to activate Foreign Key constrains
# 			Link: https://www.sqlite.org/foreignkeys.html#fk_enable"""
#             cursor.execute("PRAGMA foreign_keys = ON;")
#             # executes and commits the sql command
#             cursor.execute(sql_command)
#             conn.commit()
#             cursor.close()

#     def execute_query(self, sql_command):
#         # creates a connection to the database
#         with db.connect(self.DB_NAME, check_same_thread=False) as conn:
#             cursor = conn.cursor()
#             # executes sql command and returns fetched data
#             cursor.execute(sql_command)
#             return cursor.fetchall()

#     def insert(self, obj):
#         sql_command = self.prepare_insert(obj)
#         self.execute_non_query(sql_command)

#     def update(self, obj):
#         sql_command = self.prepare_update(obj)
#         self.execute_non_query(sql_command)

#     def delete(self, obj):
#         sql_command = self.prepare_delete(obj)
#         self.execute_non_query(sql_command)

#     def select(self, identifier):
#         # Gets the sql command from the inherited class
#         sql_command = self.prepare_select(identifier)

#         # Executes the command and fetches into result
#         result = self.execute_query(sql_command)

#         # Result receives a list of rows. Only needs the first row.
#         if len(result) > 0:
#             return self.to_object(result[0])
#         else:
#             return None

#     def select_all(self):
#         sql_command = self.prepare_select_all()
#         result = self.execute_query(sql_command)
#         return self.to_list(result)

#     def to_list(self, rows):
#         objects = []
#         for row in rows:
#             obj = self.to_object(row)
#             if obj != None:
#                 objects.append(obj)

#         return objects
