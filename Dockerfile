FROM alpine:latest

MAINTAINER jberrenberg v4.8.0

RUN apk --update --no-cache add bash ca-certificates openjdk7-jre tar wget && \
  adduser davmail -D && \
  update-ca-certificates && \
  mkdir /usr/local/davmail && \
  wget -qO - https://downloads.sourceforge.net/project/davmail/davmail/4.8.0/davmail-linux-x86_64-4.8.0-2479.tgz | tar -C /usr/local/davmail --strip-components=1 -xz && \
  mkdir /var/log/davmail && \
  chown davmail:davmail /var/log/davmail -R && \
  apk del tar

RUN apk add --update bash && rm -rf /var/cache/apk/*
# workaround for image ssl problems
RUN apk add --no-cache java-cacerts \
  && rm /usr/lib/jvm/java-1.7-openjdk/jre/lib/security/cacerts \
  && ln -s /etc/ssl/certs/java/cacerts /usr/lib/jvm/java-1.7-openjdk/jre/lib/security/cacerts

VOLUME        /etc/davmail

EXPOSE        1080
EXPOSE        1143
EXPOSE        1389
EXPOSE        1110
EXPOSE        1025
#EXPOSE        80
WORKDIR       /usr/local/davmail

#RUN  keytool -genkey -keyalg rsa -keysize 2048 -storepass password -keystore davmail.p12 -storetype pkcs12 -validity 3650 -dname cn=davmailhostname.company.com,ou=davmail,o=sf,o=net

#USER davmail


CMD ["/usr/local/davmail/davmail.sh", "/etc/davmail/davmail.properties"]
