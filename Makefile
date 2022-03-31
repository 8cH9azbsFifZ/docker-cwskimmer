build:
	docker build . -t cwskimmer:0.2 -t t20:5000/cwskimmer:0.2

run:
	docker run --rm -it -p 8080:8080 cwskimmer:0.2


push:
	docker push t20:5000/cwskimmer:0.2
