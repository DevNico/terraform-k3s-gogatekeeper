SHELL := /bin/bash
MODULE := $(notdir $(PWD))
USERID := $(shell id -u)
USERGROUP := $(shell id -g)

.PHONY: readme

readme:
	docker run --rm -e MODULE=$(MODULE) --user $(USERID):$(USERGROUP) -it -v $(PWD):/go/src/app/$(MODULE) binxio/terraform-module-readme-generator:latest
