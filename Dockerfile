# DOCKER-VERSION 0.3.4
FROM        perl:5.18.4
MAINTAINER  Gonzalo Barco gonzalo.barco@globant.com

RUN curl -L http://cpanmin.us | perl - App::cpanminus
RUN cpanm Carton Starman

RUN cachebuster=b953b35 git clone https://github.com/gbarco/wsSpreadsheet.git
RUN cd wsSpreadsheet && carton install --deployment

EXPOSE 8080

WORKDIR wsSpreadsheet
CMD carton exec starman --port 8080 bin/wsSpreadsheet.pl
