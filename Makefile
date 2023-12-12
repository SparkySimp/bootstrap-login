IMAGE_NAME=bootstrap-20231212 
BROWSER=/usr/bin/firefox
FIREFOX_PROFILE=.config/firefox
ENTRYPOINT_URI=/registry-form.html

all: run
build: prune-docker 
	docker build -t $(IMAGE_NAME) .
	mkdir -vp $(FIREFOX_PROFILE) || true

run: build
	docker run -p 8080:80 $(IMAGE_NAME) || true &
	$(BROWSER) --profile $(FIREFOX_PROFILE) --new-window --new-instance http://localhost:8080$(ENTRYPOINT_URI)

prune-docker:
	docker stop $(shell docker ps -q -f "ancestor=$(IMAGE_NAME)") || true
	docker rm $(shell docker ps -q -f "ancestor=$(IMAGE_NAME)") || true
	docker container prune -f || true

clean: prune-docker
	rm -vrf $(FIREFOX_PROFILE) || true
	pkill -f $(BROWSER) || true