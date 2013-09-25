SUBDIRS =

all_apps = $(SUBDIRS)

subdirs_clean = $(all_apps:%=%_clean)

subdirs_test  = $(all_apps:%=%_test)

subdirs_install = $(all_apps:%=%_install)

.PHONY: all test clean install \
	$(SUBDIRS) $(subdirs_clean) $(subdirs_test) $(subdirs_install)

all: $(SUBDIRS)

install: $(subdirs_install)

test: $(subdirs_test)

clean: $(subdirs_clean)


$(SUBDIRS):
	$(MAKE) -C $@ .d
	$(MAKE) -C $@ native-code
	$(MAKE) -C $@ byte-code

$(subdirs_install):
	$(MAKE) -C $(patsubst %_install,%,$@) install

$(subdirs_test):
	$(MAKE) -C $(patsubst %_test,%,$@) test

$(subdirs_clean):
	$(MAKE) -C $(patsubst %_clean,%,$@) clean

