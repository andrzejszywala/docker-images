docker network create mynet
docker run --name mysqldb --net mynet -e "MYSQL_ROOT_PASSWORD=mysql" -e "MYSQL_DATABASE=sample" -e "MYSQL_USER=mysql" -e "MYSQL_PASSWORD=mysql"-d mysql:latest
docker run -d -p 8080:8080 -e "DB_PORT=3306" --name hellojee-mysql --net mynet andrzejszywala/hellojee-mysql