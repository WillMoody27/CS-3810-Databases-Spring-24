# Instructions

This activity will use the **music** database created in the previous activity. Since you will be connecting to the database via SQL Alchemy, you need to setup the following user:

```
CREATE USER music_manager WITH PASSWORD '135791';
GRANT ALL PRIVILEGES ON TABLE albums TO music_manager;
GRANT ALL PRIVILEGES ON TABLE tracks TO music_manager;
```

Next, create a virtual environment and install the following modules:

```
psycopg2
configparser
sqlachemy

pip3 install psycopg2-binary
pip3 install configparser
pip3 install sqlalchemy
```

After installing the required modules, write the following ConfigFile.properties file:

```
[db]
host=localhost
port=5432
dbname=music
user=music_manager
password=135791
```

Then, run the code below just to check if you are able to connect to postgres via SQL Alchemy with psycopg2.

```
import configparser as cp
from sqlalchemy import create_engine
from sqlalchemy.engine import URL

config = cp.RawConfigParser()
config.read('ConfigFile.properties')
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

```

If that works: GREAT! Let's continue. Usually we write each class on its own file, but for simplification let's have everything in the same script.

```
import configparser as cp
from sqlalchemy import create_engine
from sqlalchemy.engine import URL
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker

Base = declarative_base()

class Track(Base):
    __tablename__ = "tracks"
    id = Column(Integer, ForeignKey("albums.id"), primary_key=True)
    num = Column(Integer, primary_key=True)
    name = Column(String)

class Album(Base):
    __tablename__ = "albums"
    id = Column(Integer, primary_key=True)
    title = Column(String)
    artist = Column(String)
    year = Column(Integer)
    tracks = relationship("Track", primaryjoin="Album.id==Track.id")

config = cp.RawConfigParser()
config.read('ConfigFile.properties')
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
    Session = sessionmaker(engine)
    session = Session()
    query = session.query(Album)
    for album in query.all():
        print(album.id, album.title, album.artist, album.year)
        for track in album.tracks:
            print("\t", track.num, track.name)
```

# Further Practice

Complete the to-dos in the SQL script below that implements a postgres database from the summer camp model described previously. Your script must be able to run on postgres. Make sure to apply nullable restrictions on attributes when appropriate. You must define primary on all tables that you create. Foreign keys should also be defined whenever relationships are implied from the data model.

```
CREATE DATABASE camp;

\c camp

CREATE TABLE staff (
    email VARCHAR PRIMARY KEY,
    name VARCHAR NOT NULL,
    nickname VARCHAR,
    role VARCHAR
);

INSERT INTO staff VALUES
    ('aqua@man.com', 'Aqua Man', 'aqua', 'counselor'),
    ('cat@woman.com', 'Cat Woman', 'catty', 'counselor'),
    ('green@lantern.com', 'Green Lantern', 'greenny', 'security'),
    ('drdestiny@gmail.com', 'Dr. Destiny', null, 'manager'),
    ('wolverine@gmail.com', 'James Howlett', 'wolverine', 'cook');

-- TODO: create table cabins


-- TODO: populate table cabins with: 'greenland'
(capacity of 15, 'aquaman' is the leader) and 'appalachian'
(capacity of 23, 'catwoman' is the leader)


-- TODO: update campers by adding an attribute and
a foreign key constraint to represent the relationship between campers and cabins
CREATE TABLE campers (
    id INT PRIMARY KEY,
    name VARCHAR NOT NULL,
    dob DATE NOT NULL,
    gender VARCHAR
);

INSERT INTO campers VALUES
    (1, 'Achiles', '2011-01-01', 'male', 'greenland'),
    (2, 'Apollo', '2011-02-01', 'male', 'greenland'),
    (3, 'Aphrodite', '2011-03-01', 'female', 'appalachian'),
    (4, 'Isis', '2011-04-01', NULL, 'appalachian');

CREATE TABLE programs (
    name VARCHAR PRIMARY KEY,
    descr VARCHAR NOT NULL,
    price DECIMAL(10,2)
);

INSERT INTO programs VALUES
    ('homestead', 'Our youngest adventurers learn how to make new friends,
discover self-confidence, and learn independence', 5000),
    ('outpost', 'Campers experience rewarding trips in the backcountry with the
guidance and support of counselors', 5500);

-- TODO: create a table named 'participates' to represent the relationship
between campers and programs


-- TODO: populate table 'participates' making sure that all campers are
participating in the 'homestead' program of 2022

CREATE TABLE guardians (
    email VARCHAR PRIMARY KEY,
    name VARCHAR NOT NULL
);

INSERT INTO guardians VALUES
    ('peleus@palace.com', 'Peleus'),
    ('thetis@palace.com', 'Thetis'),
    ('leto@gmail.com', 'Leto'),
    ('dione@god.com', 'Dione'),
    ('sky@god.com', 'Sky');

-- TODO: create a table to represent the relationship between campers and guardians

-- TODO: populate the table making sure that:
-- Peleus and Thetis are both guardians of Achiles
-- Leto is the solo guardian of Apollo
-- Dione is the solo guardian of Aphrodite
-- Sky is the solo guardian of Isis

from curses.ascii import EM
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, String, Integer, Float, create_engine
from sqlalchemy.orm import sessionmaker

Base = declarative_base()

class Program(Base):

    # table mapping
    __tablename__ = 'programs'

    # TODO: finish the column mapping (3 points)

    # TODO: finish the __str__ method override (3 points)
    def __str__(self):
        return ""

# db connection and session creation
db_string = "postgresql://localhost:5432/camp"
db = create_engine(db_string)
Session = sessionmaker(db)
session = Session()

# simple search
programs = session.query(Program)
for program in programs:
    print(program)
```
