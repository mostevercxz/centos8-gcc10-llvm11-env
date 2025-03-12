#docker run  --rm -it --name=c8 centos8 sleep 99
#docker run  --rm -it --name=giantdev cpp23devbase sleep 99999999
docker run --privileged --shm-size=8gb --rm -d -it -p 3456:8080 -p 12345:22 -p 28508:28508 -p 28563:28563 -p 28580:28580 -v /home/dsx/:/home/dev:Z -v /etc/timezone:/etc/timezone:ro -v /etc/localtime:/etc/localtime:ro  --name=giantdev --hostname=giant cpp23devbase
