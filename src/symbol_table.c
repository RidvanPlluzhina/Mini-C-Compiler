#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "symbol_table.h"

// Head pointer to the beginning of the linked list
Scope* current_scope = NULL;

// Function to insert a new symbol into the current scope
void insert(char* name, char* type) {
    Entry* e = malloc(sizeof(Entry));
    e->name = strdup(name);
    e->type = strdup(type);
    e->value.int_val = 0; // Initialize to 0 for int
    e->next = current_scope->entries; // Insert at the beginning of the current scope
    current_scope->entries = e;
}

// Function to look up a symbol by name in the current scope and its parents
Entry* lookup(char* name) {
    Scope* scope = current_scope;
    while (scope != NULL) {
        Entry* current = scope->entries;
        while (current != NULL) {
            if (strcmp(current->name, name) == 0)
                return current;  // return full entry, not just type
            current = current->next;
        }
        scope = scope->parent;
    }
    return NULL;
}


// Function to set the value of an existing symbol
void set_value(char* name, double value) {
    Scope* scope = current_scope;
    while (scope != NULL) {
        Entry* current = scope->entries;
        while (current != NULL) {
            if (strcmp(current->name, name) == 0) {
                if (strcmp(current->type, "int") == 0) {
                    current->value.int_val = (int)value; // Store as int
                } else if (strcmp(current->type, "float") == 0) {
                    current->value.float_val = (float)value; // Store as float
                }
                return; // Exit once the update is done
            }
            current = current->next;
        }
        scope = scope->parent; // Move to the parent scope
    }
}

// Function to get the value of a symbol by name
typed_val get_value(char* name) {
    Scope* scope = current_scope;
    typed_val result = { .val = 0.0, .type = NULL }; // Default return value
    while (scope != NULL) {
        Entry* current = scope->entries;
        while (current != NULL) {
            if (strcmp(current->name, name) == 0) {
                if (strcmp(current->type, "int") == 0) {
                    result.val = current->value.int_val;
                    result.type = "int";
                } else if (strcmp(current->type, "float") == 0) {
                    result.val = current->value.float_val;
                    result.type = "float";
                }
                return result; // Return the stored value
            }
            current = current->next;
        }
        scope = scope->parent; // Move to the parent scope
    }
    return result; // Return default value if the symbol is not found
}

// Push a new scope onto the stack
void push_scope() {
    Scope* new_scope = malloc(sizeof(Scope));
    new_scope->entries = NULL; // Initialize the new scope's entries
    new_scope->parent = current_scope; // Set the current scope as the parent
    current_scope = new_scope; // Update the current scope
}

// Pop the current scope from the stack
void pop_scope() {
    Scope* old_scope = current_scope;
    current_scope = current_scope->parent; // Restore the previous scope
    // Free the old scope's entries
    Entry* current = old_scope->entries;
    while (current != NULL) {
        Entry* temp = current;
        current = current->next;
        free(temp->name);
        free(temp->type);
        free(temp);
    }
    free(old_scope); // Free the old scope itself
}
