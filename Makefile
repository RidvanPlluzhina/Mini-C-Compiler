# Mini-C Compiler Makefile with Flex, Bison, Build, and Test Execution

# Directories
SRC_DIR = src
BUILD_DIR = build
TEST_DIR = tests

# Source files
LEX_FILE = $(SRC_DIR)/compiler.l
YACC_FILE = $(SRC_DIR)/parser.y
SYM_C = $(SRC_DIR)/symbol_table.c
SYM_H = $(SRC_DIR)/symbol_table.h

# Generated files
LEX_GEN = $(BUILD_DIR)/lex.yy.c
YACC_C = $(BUILD_DIR)/parser.tab.c
YACC_H = $(BUILD_DIR)/parser.tab.h
YACC_OUT = $(BUILD_DIR)/parser.output

# Output binary
OUT = $(BUILD_DIR)/my_compiler

# Compiler
CC = gcc
CFLAGS = -I$(SRC_DIR) -lm

# Default target
all: $(OUT)

# Step 1: Generate scanner
$(LEX_GEN): $(LEX_FILE)
	flex -o $@ $<

# Step 2: Generate parser + conflict report
$(YACC_C) $(YACC_H): $(YACC_FILE)
	bison --report=all --report-file=$(YACC_OUT) -d -o $(YACC_C) $(YACC_FILE)

# Step 3: Compile everything
$(OUT): $(LEX_GEN) $(YACC_C) $(SYM_C) $(SYM_H)
	$(CC) $(CFLAGS) -o $@ $(LEX_GEN) $(YACC_C) $(SYM_C)

# Step 4: Run tests (manual input or full test batch)
run: $(OUT)
	@echo "Running test 1:"
	@$(OUT) < $(TEST_DIR)/test1.txt
	@echo "--------------------"
	@echo "Running test 2:"
	@$(OUT) < $(TEST_DIR)/test2.txt
	@echo "--------------------"
	@echo "Running test 3:"
	@$(OUT) < $(TEST_DIR)/test3.txt
	@echo "--------------------"
	@echo "Running test 4:"
	@$(OUT) < $(TEST_DIR)/test4.txt
	@echo "--------------------"
	@echo "Running test 5:"
	@$(OUT) < $(TEST_DIR)/test5.txt
	@echo "--------------------"

# Clean generated files
clean:
	rm -f $(BUILD_DIR)/*.c $(BUILD_DIR)/*.h $(OUT) $(YACC_OUT)

.PHONY: all clean run
