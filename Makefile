PRODUCT_NAME       = DynamicBG
SRC            	   := $(wildcard *.c */*.c */*/*.c)
DKPATH             = C:/devkitARM/bin
CCPATH             = C:/cygwin64/bin
VBASIM             = C:/vba/VisualBoyAdvance.exe
FIND               = find
COPY               = cp -r


# --- File Names
ELF_NAME           = $(PRODUCT_NAME).elf
ROM_NAME           = $(PRODUCT_NAME).gba
BIN_NAME           = $(PRODUCT_NAME)

#MODEL              = -mthumb-interwork -mthumb
MODEL              = -mthumb-interwork -marm -mlong-calls #This makes interrupts work
SPECS              = -specs=gba.specs

# --- Archiver
AS                 = $(DKPATH)/arm-none-eabi-as
ASFLAGS            = -mthumb-interwork

# --- Compiler
CC                 = $(DKPATH)/arm-none-eabi-gcc
CFLAGS             = $(MODEL) -O2 -Wall -pedantic -Wextra -std=c99 -save-temps -D_ROM=$(ROM_NAME) -D_VBA=$(VBASIM)


# --- Linker
LD                 = $(DKPATH)/arm-none-eabi-gcc
LDFLAGS            = $(SPECS) $(MODEL) -lm

# --- Object/Executable Packager
OBJCOPY            = $(DKPATH)/arm-none-eabi-objcopy
OBJCOPYFLAGS       = -O binary

# --- ROM Fixer
GBAFIX             = $(DKPATH)/gbafix

# --- Delete
RM                 = rm -f

OBJECTS = $(SRC:.c=.o) 


# --- Main build target

all : clean build

run : $(ROM_NAME)
	$(VBASIM) $(ROM_NAME)


build : $(ROM_NAME)
		

# --- Build .elf file into .gba ROM file
$(ROM_NAME) : $(ELF_NAME)
	$(OBJCOPY) $(OBJCOPYFLAGS) $(ELF_NAME) $(ROM_NAME)
	$(GBAFIX) $(ROM_NAME)

# --- Build .o files into .elf file
$(ELF_NAME) : $(OBJECTS)
	$(LD) $(OBJECTS) $(LDFLAGS) -o $@

# -- Build .c files into .o files
$(OBJECTS) : %.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	$(RM) $(wildcard *.o)
	$(RM) $(wildcard *.i)
	$(RM) $(wildcard *.s)

cleanall:
	$(RM) $(ROM_NAME) $(ELF_NAME)  $(BIN_NAME)
	$(RM) $(wildcard *.o)
	$(RM) $(wildcard *.i)
	$(RM) $(wildcard *.s)

