# Instructions

Create the music database based on the following SQL schema named **music**:

```
CREATE DATABASE music;

\c music

CREATE TABLE albums (
  id SERIAL NOT NULL PRIMARY KEY,
  title VARCHAR(30) NOT NULL,
  artist VARCHAR(30) NOT NULL,
  year INT NOT NULL
);

CREATE TABLE tracks (
  id INT NOT NULL,
  num INT NOT NULL,
  name VARCHAR(30) NOT NULL,
  PRIMARY KEY (id, num),
  FOREIGN KEY (id) REFERENCES albums (id)
);
```

Create the function below called **check_year** that accepts an integer and checks if the given value is >= 1950, returning the value if valid or raising an exception otherwise.

```
CREATE FUNCTION check_year(year INT) RETURNS INT
    LANGUAGE plpgsql
    AS
    $$
        BEGIN
            IF year >= 1950 THEN
                RETURN year;
            ELSE
                RAISE EXCEPTION 'Year is invalid!!!';
            END IF;
        END;
    $$;
```

Then try to add the following albums in table **Albums**:

```
-- try to insert an album that has an invalid year
INSERT INTO albums (title, artist, year) VALUES ('Roots', 'Sepultura', check_year(1925));

-- now insert the following two albums
INSERT INTO albums (title, artist, year) VALUES ('Roots', 'Sepultura', check_year(1996));
INSERT INTO albums (title, artist, year) VALUES ('Morbid Visions', 'Sepultura', check_year(1986));
```

Now insert the following tracks:

```
INSERT INTO tracks VALUES (1, 1, 'Roots Bloody Roots');
INSERT INTO tracks VALUES (1, 2, 'Attitude');
INSERT INTO tracks VALUES (1, 3, 'Ratamahatta');
INSERT INTO tracks VALUES (2, 1, 'Morbid Visions');
INSERT INTO tracks VALUES (2, 2, 'Mayhem');
```

Create the following procedure called **number_albums** that shows the number of albums of a given artist.

```
DROP PROCEDURE IF EXISTS number_albums;
CREATE PROCEDURE number_albums(IN art VARCHAR(30))
    LANGUAGE plpgsql
    AS
    $$
        BEGIN
            PERFORM COUNT(*) FROM albums WHERE albums.artist = art;
        END;
    $$;
```

Make a call to test the procedure using:

```
CALL number_albums('Sepultura');
```
