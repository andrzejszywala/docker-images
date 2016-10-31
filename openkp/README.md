# Oficjalne obrazy Dockera dla systemu OpenKp

## Instrukcja

Jeżeli używasz Windowsa zainstaluj boot2docker zgodnie z instrukcją na [http://blog.arungupta.me/2014/07/getting-started-with-docker/](http://blog.arungupta.me/2014/07/getting-started-with-docker/)

### Dostępne obrazy
 `podstawowy` - obraz korzystający z Wildfly i wbudowanej bazy.  
 `mysql` - obraz korzystający z Wildfly i łączący się do bazy MySQL.

### Pobieranie obrazów
`docker pull openkp/openkp`  - pobranie obrazu podstawowego  
`docker pull openkp/openkp-mysql` - pobranie obrazu aplikacji korzystającej z MySQL

### Uruchomienie kontenera
Uruchomienie podstawowego obrazu:  
`docker run -p 80:8080 -d openkp/openkp`  

Uruchomienie obrazu z mysql:  
`docker run --name openkpdb -e MYSQL_USER=mysql -e MYSQL_PASSWORD=mysql -e MYSQL_DATABASE=sample -e MYSQL_ROOT_PASSWORD=supersecret -d mysql`  
`docker run --name openkpwildfly --link openkpdb:db -p 80:8080 -d openkp/openkp-mysql`

Dostęp do aplikacji [http://localhost/openkp](http://localhost/openkp)
