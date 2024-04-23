from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
 
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