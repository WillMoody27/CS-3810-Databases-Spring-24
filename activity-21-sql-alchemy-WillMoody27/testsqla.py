import configparser as cp
from sqlalchemy import create_engine
from sqlalchemy.engine import URL
from sqlalchemy.orm import sessionmaker
from models import Album, Track, Base
 
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
 
    Base.metadata.create_all(engine) # creates all tables from your model classes
 
    Session = sessionmaker(engine)
    session = Session()
 
    # to illustrate how to persist an object in the db using sqlalchemy
    album = Album(
        id = 1,
        title = 'Roots',
        artist = 'Sepultura',
        year = 1996
    )
    session.add(album)
    session.commit()
 
    query = session.query(Album)
    for album in query.all():
        print(album.id, album.title, album.artist, album.year)
        for track in album.tracks:
            print("\t", track.num, track.name)