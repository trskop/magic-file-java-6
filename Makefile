SRC_DIR = src/csource
LIB_DIR = lib
LIB_SRC = $(SRC_DIR)/nl_kb_magicfile_MagicFile.cc
LIB_BASENAME = magicjbind
LIB_TARGET = $(LIB_DIR)/$(LIB_PREFIX)$(LIB_BASENAME)$(LIB_EXT)

LDFLAGS += -shared
LDLIBS += -lmagic

SYSTEM := $(shell uname -s | sed 's/^MINGW.*/MinGW/; s/^CYGWIN.*/Cygwin/')

ifeq ($(SYSTEM),Cygwin)
# TODO: This is not yet finished.
JAVA_HOME ?= c:/opt/Java/jdk1.7.0_51

LIB_EXT = .dll

CPPFLAGS += -I"$(JAVA_HOME)/include"
CPPFLAGS += -I"$(JAVA_HOME)/include/win32"
CPPFLAGS += -I"$(shell cygpath -w /usr/include)"
else # Not Cygwin.

ifeq ($(SYSTEM),MinGW)
MINGW_JAVA_HOME ?= /c/opt/Java/jdk1.7.0_51

LIB_EXT = .dll

CXX = mingw32-g++

#CPPFLAGS += -D_JNI_IMPLEMENTATION_
CPPFLAGS += -I"$(MINGW_JAVA_HOME)/include"
CPPFLAGS += -I"$(MINGW_JAVA_HOME)/include/win32"
CPPFLAGS += -I"/include"

LDFLAGS += -Wl,--kill-at
LDFLAGS += -L/lib
else # Neither Cygwin nor MinGW.

JAVA_HOME ?= /usr/lib/jvm/java-7-oracle

LIB_PREFIX = lib
LIB_EXT = .so

CPPFLAGS += -I"$(JAVA_HOME)/include"
CPPFLAGS += -I"$(JAVA_HOME)/include/linux"
TARGET_ARCH += -fPIC

endif # End ifeq MinGW
endif # End ifeq Cygwin


all: $(LIB_TARGET)

$(LIB_TARGET): $(LIB_SRC)
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLIBS) -o $@

clean:
	rm $(LIB_TARGET)

.PHONY: all clean
