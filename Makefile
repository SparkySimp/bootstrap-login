IMAGE_NAME = first-bootstrap-app
BROWSER = /usr/bin/firefox
FIREFOX_PROFILE = .config/firefox

all: run
build: prune-docker 
	docker build -t $(IMAGE_NAME) .
	mkdir -vp $(FIREFOX_PROFILE) || true

run: build
	docker run -p 8080:80 $(IMAGE_NAME) || true &
	$(BROWSER) --profile $(FIREFOX_PROFILE) --new-window --new-instance http://localhost:8080

prune-docker:
	docker stop $(docker ps -q -f "ancestor=$(IMAGE_NAME)") || true
	docker rm $(docker ps -q -f "ancestor=$(IMAGE_NAME)") || true
	docker container prune -f || true

clean: prune-docker
	rm -vrf $(FIREFOX_PROFILE) || true
	pkill -f $(BROWSER) || true