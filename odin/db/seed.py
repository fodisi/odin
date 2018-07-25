
#!/usr/bin/python
import psycopg2
# from config import config


def connect():
    """ Connect to the PostgreSQL database server """
    conn = None
    try:
        # read connection parameters
        # params = config()

        # connect to the PostgreSQL server
        print('Connecting to the PostgreSQL database...')
        # conn = psycopg2.connect(
        #     host="localhost", database="odin", user="odin_test", password="D8cTxRGGh$1$Li9x7MUO$W3fnwbzkUMB5mzMu1kt441")

        conn = psycopg2.connect(
            host="localhost", database="odin", user="odin_app", password="123456")

        # conn = psycopg2.connect(
        #     host="localhost", database="odin", user="odin_service_catalog", password="123456")

        # create a cursor
        cur = conn.cursor()

 # execute a statement
        print('PostgreSQL database version:')

        cur.execute("insert into catalog.mytest(name) values ('joe');")
        cur.execute("insert into catalog.mytest2(name) values ('joe2');")

        # display the PostgreSQL database server version
        # cur.execute("select * from core.mytest;")
        # name = cur.fetchone()
        # print(name)

     # close the communication with the PostgreSQL
        conn.commit()
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.')


if __name__ == '__main__':
    connect()
