PKG_CONFIG ?= pkg-config
SHELL=/bin/bash

sd_var = $(shell $(PKG_CONFIG) --variable=systemd$(1) systemd)
systemdsystemconfdir = $(call sd_var,systemconfdir)
systemdsystemunitdir = $(call sd_var,systemunitdir)

PREFIX=./pkg
GIT_DIR=./netctl-git
MODULES=contrib/* docs/* services/* src/*
SOURCES=$(addprefix $(GIT_DIR)/, $(MODULES))

mvers:=$(shell cat $(GIT_DIR)/Makefile | grep -Ei "^export" | grep -Ei "VERSION" | cut -d ' ' -f4)
nvers:=$(shell cat $(GIT_DIR)/NEWS | grep -Ei "^netctl" | head -n 1 | cut -d ' ' -f2)

ifeq ($(mvers), $(nvers))
	export VERSION=$(mvers)
endif

MANDIR=$(PREFIX)/usr/share/man

MANPAGES = $(GIT_DIR)/docs/netctl.1 $(GIT_DIR)/docs/netctl-auto.1 $(GIT_DIR)/docs/netctl.profile.5 $(GIT_DIR)/docs/netctl.special.7 $(GIT_DIR)/docs/wifi-menu.1
MANPAGES_SOURCES := $(patsubst %, %.txt, $(MANPAGES))
MANPAGES_GZIP = $(patsubst %.txt, %.gz, $(MANPAGES_SOURCES))

MANPAGES_FILES := $(notdir $(MANPAGES))
MANPAGES_OUT_GZIP := $(foreach mp,$(MANPAGES_FILES),$(MANDIR)/man$(subst .,,$(suffix $(mp)))/$(mp).gz)
# MANPAGES_OUT_DIR := $(sort $(shell dirname $(MANPAGES_OUT_GZIP)))
MANPAGES_OUT_DIR := $(sort $(foreach mp,$(MANPAGES_FILES),$(MANDIR)/man$(subst .,,$(suffix $(mp)))/))

SERVICES_PREFIX=$(PREFIX)/

SERVICES_SOURCES := $(GIT_DIR)/services/*.service
SERVICES_FILES := $(notdir $(SERVICES_SOURCES))
SERVICES_OUT := $(addprefix $(SERVICES_PREFIX)$(systemdsystemunitdir)/, $(SERVICES_FILES))

PROFILE_DIR=$(PREFIX)/etc/netctl
LIB_DIR=$(PREFIX)/usr/lib/netctl
BIN_DIR=$(PREFIX)/usr/bin
IFPLUGD_DIR=$(PREFIX)/etc/ifplugd

GLOBALS_FILE=$(LIB_DIR)/globals
NETWORK_FILE=$(LIB_DIR)/network

PROFILE_PREFIX=/etc/netctl
LIB_PREFIX=/usr/lib/netctl
BIN_PREFIX=/usr/bin
IFPLUGD_PREFIX=/etc/ifplugd

GLOBALS_FILE_PREFIX=$(LIB_PREFIX)/globals
NETWORK_FILE_PREFIX=$(LIB_PREFIX)/network

.PHONY: git install uninstall clean clean-prefix clean-git

git: clean-git
	#
	# Repositories
	#
	mkdir -p $(GIT_DIR)
	git clone https://gitlab.archlinux.org/archlinux/netctl.git $(GIT_DIR)
	mkdir -p $(PREFIX)

install: $(SOURCES)
	#
	# Documentation
	#
	for i in $(MANPAGES_SOURCES) ; do \
		a2x -d manpage -f manpage -a manversion=$(VERSION) $$i ; \
	done
	for j in $(MANPAGES) ; do \
		gzip -c $$j > $$j.gz ; \
	done
	rm -rf $(MANPAGES)
	mkdir -p $(MANPAGES_OUT_DIR)
	install -m644 $(GIT_DIR)/docs/netctl.1.gz $(MANDIR)/man1/netctl.1.gz
	install -m644 $(GIT_DIR)/docs/netctl-auto.1.gz $(MANDIR)/man1/netctl-auto.1.gz
	install -m644 $(GIT_DIR)/docs/netctl.profile.5.gz $(MANDIR)/man5/netctl.profile.5.gz
	install -m644 $(GIT_DIR)/docs/netctl.special.7.gz $(MANDIR)/man7/netctl.special.7.gz
	install -m644 $(GIT_DIR)/docs/wifi-menu.1.gz $(MANDIR)/man1/wifi-menu.1.gz
	rm -rf $(MANPAGES_GZIP)
	#
	# Configuration files
	#
	install -d $(PROFILE_DIR)/{examples,hooks,interfaces}
	install -m644 $(GIT_DIR)/docs/examples/* $(PROFILE_DIR)/examples/
	#
	# Libs
	#
	install -Dt $(LIB_DIR) -m644 $(GIT_DIR)/src/lib/{globals,interface,ip,rfkill,wpa}
	install -Dt $(LIB_DIR)/connections -m644 $(GIT_DIR)/src/lib/connections/*
	install -Dt $(LIB_DIR)/dhcp -m644 $(GIT_DIR)/src/lib/dhcp/*
	install -m755 $(GIT_DIR)/src/lib/{auto.action,network} $(LIB_DIR)/
	#
	# Libs path edit
	#
	sed -e "/^NETCTL_VERSION=/c NETCTL_VERSION=\"$(VERSION)\"" \
		-e "/^PROFILE_DIR=/c PROFILE_DIR=\"$(PROFILE_PREFIX)\"" \
		-e "/^SUBR_DIR=/c SUBR_DIR=\"$(LIB_PREFIX)\"" \
		$(GIT_DIR)/src/lib/globals > $(GLOBALS_FILE)
	sed -e "/^. \/usr\/lib\/netctl\/globals/c . $(GLOBALS_FILE_PREFIX)" \
		$(GIT_DIR)/src/lib/network > $(NETWORK_FILE)
	#
	# Scripts
	#
	install -d $(BIN_DIR)
	sed -e "s|@systemdsystemconfdir@|$(systemdsystemconfdir)|g" \
	    -e "s|@systemdsystemunitdir@|$(systemdsystemunitdir)|g" \
	    -e "/^. \/usr\/lib\/netctl\/globals/c . $(GLOBALS_FILE_PREFIX)" \
	    $(GIT_DIR)/src/netctl.in > $(BIN_DIR)/netctl
	chmod 755 $(BIN_DIR)/netctl
	install -m755 \
	    $(GIT_DIR)/src/netctl-auto \
	    $(GIT_DIR)/src/wifi-menu \
	    $(BIN_DIR)/
	install -Dm755 $(GIT_DIR)/src/ifplugd.action $(IFPLUGD_DIR)/netctl.action
	#
	sed -e "/^. \/usr\/lib\/netctl\/globals/c . $(GLOBALS_FILE_PREFIX)" \
		$(GIT_DIR)/src/ifplugd.action > $(IFPLUGD_DIR)/netctl.action
	chmod 755 $(IFPLUGD_DIR)/netctl.action
	sed -e "/^. \/usr\/lib\/netctl\/globals/c . $(GLOBALS_FILE_PREFIX)" \
		$(GIT_DIR)/src/netctl-auto > $(BIN_DIR)/netctl-auto
	chmod 755 $(BIN_DIR)/netctl-auto
	sed -e "/^. \/usr\/lib\/netctl\/globals/c . $(GLOBALS_FILE_PREFIX)" \
		$(GIT_DIR)/src/wifi-menu > $(BIN_DIR)/wifi-menu
	chmod 755 $(BIN_DIR)/wifi-menu
	sed -e "/^. \/usr\/lib\/netctl\/globals/c . $(GLOBALS_FILE_PREFIX)" \
		$(GIT_DIR)/src/lib/auto.action > $(LIB_DIR)/auto.action
	chmod 755 $(LIB_DIR)/auto.action
	#
	# Services
	#
	install -Dt $(SERVICES_PREFIX)$(systemdsystemunitdir) -m644 $(GIT_DIR)/services/*.service
	install -D -m644 $(GIT_DIR)/contrib/bash-completion $(PREFIX)/usr/share/bash-completion/completions/netctl
	ln -sf netctl "$(PREFIX)/usr/share/bash-completion/completions/netctl-auto"
	ln -sf netctl "$(PREFIX)/usr/share/bash-completion/completions/wifi-menu"
	install -D -m644 $(GIT_DIR)/contrib/zsh-completion "$(PREFIX)/usr/share/zsh/site-functions/_netctl"
	#
	# Services path edit
	#
	# netctl.service
	sed -e "/^ExecStart=/c ExecStart=$(BIN_PREFIX)/netctl restore" \
		-e "/^ExecStop=/c ExecStop=$(BIN_PREFIX)/netctl store" \
		$(GIT_DIR)/services/netctl.service > $(SERVICES_PREFIX)$(systemdsystemunitdir)/netctl.service
	# netctl@.service
	sed -e "/^ExecStart=/c ExecStart=$(NETWORK_FILE_PREFIX) start %I" \
		-e "/^ExecStop=/c ExecStop=$(NETWORK_FILE_PREFIX) stop %I" \
		$(GIT_DIR)/services/netctl@.service > $(SERVICES_PREFIX)$(systemdsystemunitdir)/netctl@.service
	# netctl-auto@.service
	sed -e "/^ExecStart=/c ExecStart=$(BIN_PREFIX)/netctl-auto start %I" \
		-e "/^ExecStop=/c ExecStop=$(BIN_PREFIX)/netctl-auto stop %I" \
		-e "/^ExecStopPost=/c ExecStopPost=$(BIN_PREFIX)/netctl-auto clean %I" \
		$(GIT_DIR)/services/netctl-auto@.service > $(SERVICES_PREFIX)$(systemdsystemunitdir)/netctl-auto@.service
	# netctl-ifplugd@.service
	sed -e "/^ExecStart=/c ExecStart=$(BIN_PREFIX)/ifplugd -i %I -r $(IFPLUGD_PREFIX)/netctl.action -d 0 -bfIns" \
		-e "/^ExecStop=/c ExecStop=$(BIN_PREFIX)/ifplugd -i %I -k -W" \
		$(GIT_DIR)/services/netctl-ifplugd@.service > $(SERVICES_PREFIX)$(systemdsystemunitdir)/netctl-ifplugd@.service
	# netctl-sleep.service
	sed -e "/^ExecStart=/c ExecStart=$(BIN_PREFIX)/netctl store ; $(BIN_PREFIX)/netctl stop-all" \
		-e "/^ExecStop=-/c ExecStop=-$(BIN_PREFIX)/netctl restore" \
		$(GIT_DIR)/services/netctl-sleep.service > $(SERVICES_PREFIX)$(systemdsystemunitdir)/netctl-sleep.service
	# netctl-wait-online.service
	sed -e "/^ExecStart=/c ExecStart=$(NETWORK_FILE_PREFIX) wait-online" \
		$(GIT_DIR)/services/netctl-wait-online.service > $(SERVICES_PREFIX)$(systemdsystemunitdir)/netctl-wait-online.service

all: $(SOURCES) install

uninstall:
	rm -rf $(GIT_DIR) $(manpages_out)
	rm -rf $(PROFILE_DIR)/
	rm -rf $(LIB_DIR)/
	rm -rf $(BIN_DIR)/netctl
	rm -rf $(BIN_DIR)/netctl-auto
	rm -rf $(BIN_DIR)/wifi-menu
	rm -rf $(IFPLUGD_DIR)/netctl.action $(PREFIX)/usr/share/bash-completion/completions/netctl
	rm -rf $(PREFIX)/usr/share/zsh/site-functions/_netctl
	rm -rf $(SERVICES_OUT)

clean:
	rm -rf $(MANPAGES)
	rm -rf $(MANPAGES_GZIP)

clean-prefix: clean
	rm -rf $(PREFIX)

clean-git: clean-prefix
	rm -rf $(GIT_DIR)
