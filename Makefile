VER=0.5

build:
	docker build . -t cwskimmer:${VER} -t t20:5000/cwskimmer:${VER}

run:
	docker run -e RIGSERVER=10.101.1.53 -e RIGSERVER_CAT_PORT=1234 -e RIGSERVER_PTT_PORT=4321 --rm -it -p 8080:8080 cwskimmer:${VER}

push:
	docker push t20:5000/cwskimmer:${VER}
