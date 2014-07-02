
# name of your library
libname = libfoo.a

# source files
# assumes the source is located in the subfolder 'src'
sources = $(wildcard src/*.c)

# creates list of object files by replacing the file extensions with .o (i.e., foo.c -> foo.o)
objects = $(sources:.c=.o)

# include directories
# assuming your header files reside in the subfolder 'include'
includes = -Iinclude

# flags that may be understood by both the compiler and the linker
commonflags =

# compiler flags
CFLAGS = $(commonflags) -g -Wall -Wextra $(includes)

# linker flags
LDFLAGS = $(commonflags) -lm

# compiler
CC = gcc

.SUFFIXES: .c

default: $(libname)

$(libname): $(objects)
	@echo "[ar] $(libname)"
	@ar rcsv $(libname) $(objects)
	@ranlib $(libname)

clean:
	@echo "[rm] $(objects)"
	@$(RM) $(objects)

dist-clean: clean
	@echo "[rm] $(libname)"
	@$(RM) $(libname)

rebuild: dist-clean default

help:
	@echo "supported commands"
	@echo "   'help'          show this help"
	@echo "   'default'       build '$(libname)' (default operation)"
	@echo "   'clean'         delete generated object files"
	@echo "   'dist-clean'    invoke 'clean', and delete '$(libname)' as well"
	@echo "   'rebuild'       invoke 'dist-clean', and then 'default'"

.c.o:
	$(CC) $(CFLAGS) -c $(PWD)/$< -o $(PWD)/$@

