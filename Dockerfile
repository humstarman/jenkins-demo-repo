FROM ubuntu:16.04
ADD entrypoint /
RUN chmod +x /entrypoint.sh 
