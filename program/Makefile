CC=gcc
AR=ar
RANLIB=ranlib
SRCDIR=src/
BSRCDIR=$(SRCDIR)beer/

CFILES=$(wildcard $(SRCDIR)*.c)
_OFILES=$(patsubst %.c,%.o,$(CFILES))

BCFILES=$(wildcard $(BSRCDIR)*.c)
_BOFILES=$(patsubst %.c,%.o,$(BCFILES))

TARGETDIR=release/
ODIR=$(TARGETDIR)obj/
BODIR=$(ODIR)beer/
OFILES=$(patsubst $(SRCDIR)%,$(ODIR)%,$(_OFILES))
BOFILES=$(patsubst $(BSRCDIR)%,$(BODIR)%,$(_BOFILES))
TARGET=$(TARGETDIR)program

DTARGETDIR=debug/
DODIR=$(DTARGETDIR)debug_obj/
BDODIR=$(DODIR)beer/
DOFILES=$(patsubst $(SRCDIR)%,$(DODIR)%,$(_OFILES))
BDOFILES=$(patsubst $(BSRCDIR)%,$(BDODIR)%,$(_BOFILES))
DTARGET=$(DTARGETDIR)program

INC = -I inc/
INC += -I inc/beer/
INC += -I ../animals/inc 
INC += -I ../cars/inc

LIB= -lcars -lanimals
LIBDIR= -L ../cars/

RLIBDIR = -L ../animals/release/

DLIBDIR = -L ../animals/debug/

LDFLAGS = --static $(LIBDIR)

CFLAGS=-Wall -std=c99 $(INC) -MMD -MP
ARFLAGS=rcs

.PHONY: all clean debug profile

all: pre-build $(TARGET)
all: CFLAGS += -O2 
all: LDFLAGS += $(RLIBDIR)

debug: CFLAGS +=-DDEBUG -g -pg 
debug: LDFLAGS +=$(DLIBDIR) -g -pg 
debug: pre-build $(DTARGET)

profile: CFLAGS +=-DPROFILE -g -pg 
profile: LDFLAGS +=-g -pg 
profile: pre-build $(TARGET)

-include $(OFILES:%.o=%.d)
-include $(BOFILES:%.o=%.d)
-include $(DOFILES:%.o=%.d)
-include $(BDOFILES:%.o=%.d)

pre-build:
	@mkdir -p $(ODIR)
	@mkdir -p $(DODIR)
	@mkdir -p $(BODIR)
	@mkdir -p $(BDODIR)
	@mkdir -p $(TARGETDIR)
	@mkdir -p $(DTARGETDIR)
	 
$(ODIR)%.o $(DODIR)%.o: $(SRCDIR)%.c
	$(CC) $(CFLAGS) -c $< -o $@ 

$(TARGET): $(OFILES) $(BOFILES)
	$(CC) $(LDFLAGS) -o $@ $^ $(LIB)

$(DTARGET): $(DOFILES) $(BDOFILES)
	$(CC) $(LDFLAGS) -o $@ $^ $(LIB)

clean:
	@rm -rf $(ODIR)
	@rm -rf $(DODIR)
	@rm -rf $(TARGETDIR)
	@rm -rf $(DTARGETDIR)
