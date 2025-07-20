#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

#include "typed_val.h"  // Include the single definition

typedef struct entry {
    char* name;          // Name of the symbol
    char* type;          // Type ("int", "float")
    union {
        int int_val;
        float float_val;
    } value;
    struct entry* next;
} Entry;

typedef struct Scope {
    Entry* entries;
    struct Scope* parent;
} Scope;

// Function declarations
void insert(char* name, char* type);
Entry * lookup(char* name);
void set_value(char* name, double value);
typed_val get_value(char* name);
void push_scope();
void pop_scope();

#endif