SRC_DIR = src/csource
LIB_DIR = lib
LIB_SRC = $(SRC_DIR)/nl_kb_magicfile_MagicFile.cc
LIB_BASENAME = magicjbind
LIB_TARGET = $(LIB_DIR)/$(LIB_PREFIX)$(LIB_BASENAME)$(LIB_EXT)

LDFLAGS += -shared
LDLIBS += -lmagic

SYSTEM := $(shell uname -s | sed 's/^MINGW.*/MinGW/; s/^CYGWIN.*/Cygwin/')

ifeq ($(SYSTEM),MinGW)

# Modify /etc/fstab in Msys to mount Java installation directory.
MINGW_JAVA_HOME ?= /java

LIB_EXT = .dll

CXX = mingw32-g++

CPPFLAGS += -I$(MINGW_JAVA_HOME)/include
CPPFLAGS += -I$(MINGW_JAVA_HOME)/include/win32
CPPFLAGS += -I/include

LDFLAGS += -L/lib

# http://www.mingw.org/wiki/JNI_MinGW_DLL
CPPFLAGS += -D_JNI_IMPLEMENTATION_
LDFLAGS += -Wl,--kill-at

else # Not MinGW.

JAVA_HOME ?= /usr/lib/jvm/default-java

LIB_PREFIX = lib
LIB_EXT = .so

CPPFLAGS += -I$(JAVA_HOME)/include
CPPFLAGS += -I$(JAVA_HOME)/include/linux
TARGET_ARCH += -fPIC

endif # End ifeq MinGW.


all: $(LIB_TARGET)

$(LIB_TARGET): $(LIB_SRC)
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLIBS) -o $@

clean:
	rm $(LIB_TARGET)

.PHONY: all clean
