PROJECT=$(shell basename $$PWD)
PROJECT_DIR=$(shell if [[ $$PWD =~ \/go\/src  ]]; then echo $$PWD | sed 's/.*\(\/go\/.*\)/\1/g'; else echo '/go/src/github.com/callmeradical/$(PROJECT)'; fi)
.PHONY: build_docker_image plugins
plugins:
	docker run -tP -v $(PWD):$(PROJECT_DIR) -w $(PROJECT_DIR) plugin_builder:latest /bin/sh -c "go build -buildmode=plugin -o eng/eng.so eng/greeter.go && go build -buildmode=plugin -o chi/chi.so chi/greeter.go"

.PHONY: build_docker_image
build_docker_image:
	docker build -t plugin_builder:latest .

.PHONY: greeter
greeter:
	docker run -tP -v $(PWD):$(PROJECT_DIR) -w $(PROJECT_DIR) plugin_builder:latest /bin/sh -c "go run main.go english"
	docker run -tP -v $(PWD):$(PROJECT_DIR) -w $(PROJECT_DIR) plugin_builder:latest /bin/sh -c "go run main.go chinese"
