hellojee 
wildfly 
embedded database

Build and run:
```
docker build -t hellojee .
docker run -it -p 8080:8080 hellojee
curl http://localhost:8080/hellojee/resources/hello 

```