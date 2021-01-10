DOCKERFILE	= Dockerfi
PORT				= 8080
TAG					= demo-container

build:
	docker build -t $(TAG) .

run:
	docker run -itd --name $(TAG) -it -p 8888:$(PORT) --rm $(TAG)

run-blue:
	docker run -itd --name $(TAG) -it -p 8888:$(PORT) --rm --env='ENV=blue' $(TAG)

run-green:
	docker run -itd --name $(TAG) -it -p 8888:$(PORT) --rm --env='ENV=green' $(TAG)

contener=`docker ps -a -q`
image=`docker images | awk '/^<none>/ { print $$3 }'`

clean:
	@if [ "$(image)" != "" ] ; then \
    docker rmi $(image); \
  fi
	@if [ "$(contener)" != "" ] ; then \
    docker rm -f $(contener); \
  fi
