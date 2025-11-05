
SOURCE?=install.img

build build/root build/root/data:
	@if [ -e $@ ]; then \
	        echo "$@/ exists and is not a directory"; \
		exit 1; \
	elif [ ! -d $@ ]; then \
		echo "creating directory $@/"; \
	        mkdir --parents $@; \
	fi

	@touch $@

# "usr" = extracted
build/root/usr: build/root install.img 
	tar xpf "$(SOURCE)" --xattrs-include="*" -C build/root
	mv build/root/boot{.def,}
	@touch $@

build/root/etc.def: build/root/usr
build/root/var.def: build/root/usr

build/root/data/etc: build/root/data build/root/etc.def
	if [ -e build/root/data/etc ]; then rm -rf build/root/data/etc; fi
	mv build/root/etc.def build/root/data/etc

build/root/data/var: build/root/data build/root/var.def
	if [ -e build/root/data/var ]; then rm -rf build/root/data/var; fi
	mv build/root/var.def build/root/data/var

mntbind/%: build/root
	if ! mountpoint $* >/dev/null 2>&1; then \
		mkdir --parents "build/root/$*" && \
		mount --bind "/$*" "build/root/$*"; \
	fi

databind/%: build/root/data/$*
	if ! mountpoint $* >/dev/null 2>&1; then \
		mkdir --parents "build/root/$*" && \
		mount --bind "build/root/data/$*" "build/root/$*"; \
	fi

mntbind: mntbind/proc mntbind/sys mntbind/dev mntbind/tmp mntbind/run
databind: databind/etc databind/var databind/home databind/root


	

build/root/all:
