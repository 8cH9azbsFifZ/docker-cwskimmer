VER=0.8

# Must be LOWERCASE
USER=8ch9azbsfifz
REPO=docker-cwskimmer
TAG=ghcr.io/${USER}/${REPO}/cwskimmer

build:
	docker build . -t ${TAG}:${VER} -t ${TAG}:latest

run:
	docker run --rm -it -e CALLSIGN=123 -p 8080:8080 -p 7301:7300 ${TAG}:${VER}

push:
	docker push ${TAG}:${VER}

update_patt3ch:
	wget http://www.reversebeacon.net/downloads/patt3ch/patt3ch.lst -O ./install/patt3ch/patt3ch.lst
