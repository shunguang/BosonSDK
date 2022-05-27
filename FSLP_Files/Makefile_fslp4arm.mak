#this Makefile outputs image as a static lib for <PLTF> machine

PROJ_NAME=libFslp
SDIR_PROJ = /home/debian/pnt/debianEnv/pkg/BosonSDK_rev206/SDK_USER_PERMISSIONS/FSLP_Files/src
SDIR_INC = /home/debian/pnt/debianEnv/pkg/BosonSDK_rev206/SDK_USER_PERMISSIONS/FSLP_Files/src/inc

ODIR_OBJ = /home/debian/pnt/debianEnv/pkg/BosonSDK_rev206/SDK_USER_PERMISSIONS/FSLP_Files/obj
ODIR_LIB = /home/debian/pnt/debianEnv/pkg/BosonSDK_rev206/SDK_USER_PERMISSIONS/FSLP_Files/


PLTF_INC=/usr/include

CXX = /usr/bin/g++

#DEBUG = -O3 -g0 -DNDEBUG
#DEBUG = -O0 -g3 -DDEBUG

DEBUG = -O3 -g0 -DNDEBUG

#include flags for building libs
CFLAGS = -Wall -static -c $(DEBUG) -DECL_STANDALONE=1 -DqDNGDebug=1 -D__xlC__=1 -DNO_FCGI_DEFINES=1 -DqDNGUseStdInt=0 -DUNIX_ENV=1 -D__LITTLE_ENDIAN__=1 -DqMacOS=0 -DqWinOS=0 -std=gnu++14 \
	-I$(SDIR_PROJ) -I$(SDIR_INC) -I$(PLTF_INC)

TARGETFILE=$(ODIR_LIB)/$(PROJ_NAME).a


OBJS = \
	$(ODIR_OBJ)/flirChannels.o \
	$(ODIR_OBJ)/flirCRC.o \
	$(ODIR_OBJ)/FSLP.o \
	$(ODIR_OBJ)/timeoutLogic.o \
	$(ODIR_OBJ)/serialPortAdapter.o \
	$(ODIR_OBJ)/serial.o
	
default:  directories $(TARGETFILE)

directories:    
	mkdir -p $(ODIR_OBJ)
	mkdir -p $(ODIR_LIB)

#the output lib file name is <$(TARGETFILE)>
$(TARGETFILE) : $(OBJS)
	ar rcs $(TARGETFILE) $(OBJS)

$(ODIR_OBJ)/flirChannels.o: $(SDIR_PROJ)/flirChannels.c $(SDIR_INC)/flirChannels.h
	$(CXX) -o $(ODIR_OBJ)/flirChannels.o $(CFLAGS) $(SDIR_PROJ)/flirChannels.c

$(ODIR_OBJ)/flirCRC.o: $(SDIR_PROJ)/flirCRC.c $(SDIR_INC)/flirCRC.h
	$(CXX) -o $(ODIR_OBJ)/flirCRC.o $(CFLAGS) $(SDIR_PROJ)/flirCRC.c

$(ODIR_OBJ)/FSLP.o: $(SDIR_PROJ)/FSLP.c $(SDIR_INC)/FSLP.h
	$(CXX) -o $(ODIR_OBJ)/FSLP.o $(CFLAGS) $(SDIR_PROJ)/FSLP.c

$(ODIR_OBJ)/timeoutLogic.o: $(SDIR_PROJ)/timeoutLogic.c $(SDIR_INC)/timeoutLogic.h
	$(CXX) -o $(ODIR_OBJ)/timeoutLogic.o $(CFLAGS) $(SDIR_PROJ)/timeoutLogic.c

$(ODIR_OBJ)/serialPortAdapter.o: $(SDIR_PROJ)/linux/serialPortAdapter.c $(SDIR_INC)/serialPortAdapter.h $(SDIR_PROJ)/linux/serial.h
	$(CXX) -o $(ODIR_OBJ)/serialPortAdapter.o $(CFLAGS) $(SDIR_PROJ)/linux/serialPortAdapter.c

$(ODIR_OBJ)/serial.o: $(SDIR_PROJ)/linux/serial.c $(SDIR_PROJ)/linux/serial.h
	$(CXX) -o $(ODIR_OBJ)/serial.o $(CFLAGS) $(SDIR_PROJ)/linux/serial.c

clean:
	\rm -r $(ODIR_OBJ)/*.o $(TARGETFILE)
