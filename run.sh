#!/bin/bash
docker run -p 1110:1110 -v /data/davmail/davmail.properties:/etc/davmail/davmail.properties docker-davmail
