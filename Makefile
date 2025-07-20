# Mini-C Compiler Makefile

# Directories
SRC_DIR = src
BUILD_DIR = build
TEST_DIR = tests

# Tools
LEX = flex
YACC = bison
CC = gcc
CFLAGS = -I$(SRC_DIR) -lm

# Targets
all: $(BUILD_DIR)/my_compiler

# Lexer generation
$(BUILD_DIR)/lex.yy.c: $(SRC_DIR)/compiler.l
	@mkdir -p $(BUILD_DIR)
	$(LEX) -o $@ $<

# Parser generation
$(BUILD_DIR)/parser.tab.c $(BUILD_DIR)/parser.tab.h: $(SRC_DIR)/parser.y
	@mkdir -p $(BUILD_DIR)
	$(YACC) -d -o $(BUILD_DIR)/parser.tab.c $<

# Final compilation
$(BUILD_DIR)/my_compiler: $(BUILD_DIR)/lex.yy.c $(BUILD_DIR)/parser.tab.c $(SRC_DIR)/symbol_table.c
	$(CC) $(CFLAGS) -o $@ $^

# Run tests
run: $(BUILD_DIR)/my_compiler
	@for test in $(TEST_DIR)/test*.txt; do \
		echo "Running $$test:"; \
		$(BUILD_DIR)/my_compiler < $$test; \
		echo "--------------------"; \
	done

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean run