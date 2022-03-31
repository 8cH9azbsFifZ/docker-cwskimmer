build:
	docker build . -t cwskimmer
	docker build . -t t20:5000/cwskimmer:0.1

run:
	docker run --rm -it -p 8080:8080 cwskimmer


push:
	docker push t20:5000/cwskimmer:0.1
