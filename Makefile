SRC_DIR = src/csource
LIB_DIR = lib
LIB_SRC = $(SRC_DIR)/nl_kb_magicfile_MagicFile.cc
LIB_TARGET = $(LIB_DIR)/libmagicjbind.so

CPPFLAGS += -I$(JAVA_HOME)/include
# TODO: MinGW:
CPPFLAGS += -I$(JAVA_HOME)/include/linux
LDFLAGS += -shared
TARGET_ARCH += -fPIC
LDLIBS += -lmagic

# TODO: System dependent value.
JAVA_HOME ?= /usr/lib/jvm/java-7-oracle

all: $(LIB_TARGET)

$(LIB_TARGET): $(LIB_SRC)
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLIBS) -o $@
