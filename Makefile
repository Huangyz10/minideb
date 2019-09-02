BUILD_DIR := build
MKDIR_P = mkdir -p
RM = rm -rf

.PHONY: build clean clobber

all: build
#删除build
clean:
	${RM} ${CURDIR}/${BUILD_DIR}
#删除.installed-requirements
clobber: clean
	@${RM} .installed-requirements
#启动pre-build.sh,安装需要的packages
.installed-requirements:
	@echo "Installing required packages..."
	@./pre-build.sh
	@touch $@
#启动buildall
build: .installed-requirements
	@echo "Building all supported distros..."
	@./buildall

%:
	@echo "Building $@..."
	@$(MAKE) .installed-requirements
	@${MKDIR_P} ${CURDIR}/${BUILD_DIR}
	./mkimage ${CURDIR}/${BUILD_DIR}/$@.tar $@

test-%:
	@cat ${CURDIR}/${BUILD_DIR}/$*.tar | docker import - minideb:$*
	@./test minideb:$*
