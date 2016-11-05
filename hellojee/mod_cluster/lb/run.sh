#!/bin/sh

docker run --name lb -it --rm --net mynet -p 80:80 -p 433:433 lb