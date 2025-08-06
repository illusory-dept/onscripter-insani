# -*- Makefile -*-
#
# MacOSX.mk - Makefile rules for MacOS X
#   Thanks adas-san, Takano-san and tmkk-san
#

INCS = `sdl2-config --cflags` `smpeg-config --cflags` -I/opt/homebrew/include

LIBS = `sdl2-config --libs` `smpeg-config --libs` `freetype-config --libs` -lSDL2_ttf -lSDL2_image -lSDL2_mixer -lbz2 -lm -ljpeg -framework AVFoundation -framework CoreFoundation
DEFS = -DMACOSX -DUTF8_CAPTION -DUTF8_FILESYSTEM

EXESUFFIX =
OBJSUFFIX = .o

.SUFFIXES:
.SUFFIXES: $(OBJSUFFIX) .cpp .h

CC = c++ 
LD = c++ -o

#CFLAGS = -g -Wall -Wpointer-arith -pipe -c $(INCS) $(DEFS)
CFLAGS = -O3 -Wall -Wpointer-arith -pipe -c $(INCS) $(DEFS)
RM = rm -f

TARGET = onscripter$(EXESUFFIX) sardec$(EXESUFFIX) nsadec$(EXESUFFIX) sarconv$(EXESUFFIX) nsaconv$(EXESUFFIX)

include onscripter.mk
