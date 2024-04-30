# Instructions

This activity will explain how to run MongoDB as a docker container. First, dowload MonogDB official docker image issuing (on the terminal):

```
docker pull mongo
```

Next, create a folder where MongoDB will save the database files. For example, name it **mongodb**. Copy the complete path to that folder. I created my folder at:

```
/Users/tmota/devel/teach/__24SCS3810_DB/mongodb
```

Start your MongoDB container mapping an external volume to the folder you created previously.

```
docker run --rm --name mongodb -v /Users/tmota/devel/teach/__24SCS3810_DB/mongodb:/data/db mongo


<!-- MINE -->
docker run --rm --name mongodb -v /Users/williamhellems-moody/Documents/spring-2024/3180-databases/mongodb:/data/db mongo
```

Connect to your container issuing:

```
docker exec -it mongodb bash

<!-- OR -->

docker exec -it mongodb mongosh
```

The command above allows you to connect to your container using its shell interpreter (named **bash**). Once "in" the container you just need to execute **mongosh** (mongo's shell, like **psql** from postgres).

```
mongosh
```

Now open **students.js** script and run the statements one at a time.

To exit from **mongosh** just type **exit** and enter. Then run **exit** again to exit from the container's **bash**.
