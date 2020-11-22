
IMANAGER_VERSION ?= 0.0.1
IMANAGER_RELEASE ?= 1

.PHONY: default
default: help
all: help

### help:		Show Makefile rules.
.PHONY: help
help:
	@echo Makefile rules:
	@echo
	@grep -E '^### [-A-Za-z0-9_]+:' Makefile | sed 's/###/   /'
	@echo
	@echo "imanager version: $(IMANAGER_VERSION).$(IMANAGER_RELEASE)"


### install:		Install service.
.PHONY: install
install:
	./imanager.sh install

### start:		Start service.
.PHONY: start
start:
	./imanager.sh start

### stop:		Stop service.
.PHONY: stop
stop:
	./imanager.sh stop

### reload:		Reload service.
.PHONY: reload
reload:
	./imanager.sh reload

### restart:		Restart service.
.PHONY: restart
restart:
	./imanager.sh restart

### update:		Update service.
.PHONY: update
update:
	./imanager.sh update

### uninstall:		Uninstall service.
.PHONY: uninstall
uninstall:
	./imanager.sh uninstall