#include <stdlib.h>      // For malloc and free functions
#include <string.h>      // For string manipulation functions like strdup and strcmp
#include <stdio.h>       // For standard I/O
#include "symbol_table.h" // Include a header file for declarations

// Define the structure for a symbol table entry
typedef struct entry {
    char* name;          // Name of the symbol (e.g., variable name)
    char* type;          // Type of the symbol (e.g., "int", "float")
    double value;        // Value associated with the symbol
    struct entry* next;  // Pointer to the next entry in the linked list
} Entry;

// Head pointer to the beginning of the linked list
Entry* head = NULL;

// Function to insert a new symbol into the symbol table
void insert(char* name, char* type) {
    // Allocate memory for the new entry
    Entry* e = malloc(sizeof(Entry));

    // Duplicate and assign the name and type strings
    e->name = strdup(name);    // strdup allocates memory and copies the string
    e->type = strdup(type);

    // Initialize the value to 0.0 by default
    e->value = 0.0;

    // Insert at the beginning of the linked list
    e->next = head;
    head = e;
}

// Function to look up the type of a symbol by its name
char* lookup(char* name) {
    Entry* current = head;

    // Traverse the list until the symbol is found or the end is reached
    while (current != NULL) {
        if (strcmp(current->name, name) == 0)  // Check if names match
            return current->type;              // Return the type if match is found
        current = current->next;
    }

    // Return NULL if the symbol is not found
    return NULL;
}

// Function to set the value of an existing symbol
void set_value(char* name, double value) {
    Entry* current = head;

    // Traverse the list to find the matching symbol
    while (current != NULL) {
        if (strcmp(current->name, name) == 0) {
            current->value = value;  // Update the value
            return;                  // Exit once the update is done
        }
        current = current->next;
    }
}

// Function to get the value of a symbol by name
double get_value(char* name) {
    Entry* current = head;

    // Traverse the list to find the matching symbol
    while (current != NULL) {
        if (strcmp(current->name, name) == 0)
            return current->value;  // Return the stored value
        current = current->next;
    }

    // Return default value 0.0 if the symbol is not found
    return 0.0;
}