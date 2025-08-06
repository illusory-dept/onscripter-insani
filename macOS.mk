
INCS = `sdl2-config --cflags` \
       `pkg-config --cflags SDL2_image SDL2_mixer SDL2_ttf freetype2 harfbuzz`

# Turn this on to debug
#LIBS = `sdl2-config --libs` \
#       `pkg-config --libs SDL2_image SDL2_mixer SDL2_ttf freetype2 harfbuzz` \
#       -lbz2 -ljpeg -lm -lmpg123 -F/Library/Frameworks -framework AVFoundation -framework CoreFoundation -framework Foundation -framework SDL2 -framework Cocoa
# Turn this on for redist build
LIBS = `sdl2-config --libs` \
       `pkg-config --libs SDL2_image SDL2_mixer SDL2_ttf freetype2 harfbuzz` \
       -lbz2 -ljpeg -lm \
       -framework Foundation \
       -framework Cocoa
DEFS = -DMACOSX -DUTF8_CAPTION -DUSE_OGG_VORBIS -DUTF8_FILESYSTEM -DINSANI -DENABLE_1BYTE_CHAR -DFORCE_1BYTE_CHAR
#DEFS += -DAPPBUNDLE

EXESUFFIX =
OBJSUFFIX = .o

.SUFFIXES:
.SUFFIXES: $(OBJSUFFIX) .cpp .h

CC = c++
# Turn this on to debug
#LD = c++ -fsanitize=address -fno-omit-frame-pointer -o
# Turn this on for redist build
LD = c++ -o

# Turn this on to debug
#CFLAGS = -g -ObjC++ -Wall -fsanitize=address -fno-omit-frame-pointer -Wpointer-arith -pipe -c $(INCS) $(DEFS)
# Turn this on for redist build
CFLAGS = -g -ObjC++ -O3 -Wall -Wpointer-arith -pipe -c $(INCS) $(DEFS)
RM = rm -f

TARGET = onscripter$(EXESUFFIX) sardec$(EXESUFFIX) nsadec$(EXESUFFIX) sarconv$(EXESUFFIX) nsaconv$(EXESUFFIX)

include onscripter.mk
