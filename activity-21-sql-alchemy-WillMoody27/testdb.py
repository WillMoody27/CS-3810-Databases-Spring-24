import configparser as cp
from sqlalchemy import create_engine
from sqlalchemy.engine import URL
 
config = cp.RawConfigParser()
config.read('src/config.ini')
params = dict(config.items('db'))
 
url = URL.create(
    "postgresql+psycopg2",
    username=params['user'],
    password=params['password'],
    host=params['host'],
    port=params['port'],
    database=params['dbname']
)
 
engine = create_engine(url)
if engine:
    print('Connection to Postgres database ' + params['dbname'] + ' was successful!')