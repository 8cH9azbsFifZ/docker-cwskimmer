VER=0.5

build:
	docker build . -t cwskimmer:${VER} -t t20:5000/cwskimmer:${VER}

run:
	docker run --rm -it -p 8080:8080 cwskimmer:${VER}

push:
	docker push t20:5000/cwskimmer:${VER}
