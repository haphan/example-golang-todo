.PHONY: clean test run

default:
	make clean
	go get
	make build

test:
	echo 'OK'

build:
	go build -o bin/app

clean:
	rm -rf bin/*

run:
	./bin/app