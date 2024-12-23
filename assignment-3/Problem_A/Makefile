# Compiler and assembler
CXX = g++
AS = as

# Compiler flags
CXXFLAGS = -c 
LDFLAGS = -z noexecstack

# Assembly source and object files
ASM_SRC = selection_sort.s
ASM_OBJ = selection_sort.o

# C++ source and object files
CPP_SRC = main.cpp
CPP_OBJ = main.o

# Final output executable
OUT = main

# Default target to build the executable
all: $(OUT)

# Rule to link object files into the executable
$(OUT): $(CPP_OBJ) $(ASM_OBJ)
	$(CXX) $(CPP_OBJ) $(ASM_OBJ) -o $(OUT) $(LDFLAGS)

# Rule to assemble .s file to .o file
$(ASM_OBJ): $(ASM_SRC)
	$(AS) -o $(ASM_OBJ) $(ASM_SRC)

# Rule to compile .cpp file to .o file
$(CPP_OBJ): $(CPP_SRC)
	$(CXX) $(CXXFLAGS) $(CPP_SRC) -o $(CPP_OBJ)

# Clean up generated files
clean:
	rm -f $(CPP_OBJ) $(ASM_OBJ) $(OUT)

# Phony targets (not actual files)
.PHONY: all clean

