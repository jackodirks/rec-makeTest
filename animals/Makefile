#$(CC) -MMD $(CFLAGS) $< $@.d
CC=gcc
AR=ar
RANLIB=ranlib
SRCDIR=src/
CFILES=$(wildcard $(SRCDIR)*.c)
_OFILES=$(patsubst %.c,%.o,$(CFILES))
INC= -I inc/
LIB=
LIBDIR= -L lib/
#LDFLAGS=-s $(LIB)
LDFLAGS=
CFLAGS=-Wall -std=c99 $(INC) -MMD -MP
ARFLAGS=rcs

ODIR=obj/
OFILES=$(patsubst src/%,$(ODIR)%,$(_OFILES))

DODIR= debug_obj/
DOFILES=$(patsubst src/%,$(DODIR)%,$(_OFILES))

TARGETDIR=release/
TARGET=$(TARGETDIR)libanimals.a

DTARGETDIR=debug/
DTARGET=$(DTARGETDIR)libanimals.a


.PHONY: all clean debug profile

all: pre-build $(TARGET)
all: CFLAGS += -O2 
all: LDFLAGS += 

debug: CFLAGS +=-DDEBUG -g -pg 
debug: LDFLAGS +=-g -pg 
debug: pre-build $(DTARGET)

profile: CFLAGS +=-DPROFILE -g -pg 
profile: LDFLAGS +=-g -pg 
profile: pre-build $(TARGET)

-include $(OFILES:%.o=%.d)
-include $(DOFILES:%.o=%.d)

pre-build:
	@mkdir -p $(ODIR)
	@mkdir -p $(DODIR)
	@mkdir -p $(TARGETDIR)
	@mkdir -p $(DTARGETDIR)
	 
$(DODIR)%.o: $(SRCDIR)%.c
	$(CC) $(CFLAGS) -c $< -o $@ 

$(ODIR)%.o: $(SRCDIR)%.c
	$(CC) $(CFLAGS) -c $< -o $@ 

$(TARGET): $(OFILES) 
	$(AR) $(ARFLAGS) $@ $^

$(DTARGET): $(DOFILES)
	$(AR) $(ARFLAGS) $@ $^

clean:
	@rm -rf $(ODIR)
	@rm -rf $(DODIR)
	@rm -rf $(TARGETDIR)
	@rm -rf $(DTARGETDIR)
