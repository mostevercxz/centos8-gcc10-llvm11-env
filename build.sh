#docker build --network=host -t centos8:latest .
#docker build --progress=plain -t cpp20devbase:latest . -f ./Dockerfile.cpp20devbase
docker build --progress=plain -t cpp23devbase:latest . -f ./Dockerfile.cpp23devbase
