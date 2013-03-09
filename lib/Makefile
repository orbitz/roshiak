SUBDIRS =

all_apps = $(SUBDIRS)

subdirs_clean = $(all_apps:%=%_clean)

subdirs_test  = $(all_apps:%=%_test)

.PHONY: all test clean $(SUBDIRS) $(subdirs_clean) $(subdirs_test)

all: $(SUBDIRS)

test: $(subdirs_test)

clean: $(subdirs_clean)


$(SUBDIRS):
	$(MAKE) -C $@ .d
	$(MAKE) -C $@ native-code
	$(MAKE) -C $@ byte-code

$(subdirs_test):
	$(MAKE) -C $(patsubst %_test,%,$@) test

$(subdirs_clean):
	$(MAKE) -C $(patsubst %_clean,%,$@) clean

