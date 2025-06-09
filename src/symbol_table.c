#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "symbol_table.h"

typedef struct entry {
    char* name;
    char* type;
    double value;
    struct entry* next;
} Entry;

Entry* head = NULL;

void insert(char* name, char* type) {
    Entry* e = malloc(sizeof(Entry));
    e->name = strdup(name);
    e->type = strdup(type);
    e->value = 0.0;  // default value
    e->next = head;
    head = e;
}

char* lookup(char* name) {
    Entry* current = head;
    while (current != NULL) {
        if (strcmp(current->name, name) == 0)
            return current->type;
        current = current->next;
    }
    return NULL;
}

void set_value(char* name, double value) {
    Entry* current = head;
    while (current != NULL) {
        if (strcmp(current->name, name) == 0) {
            current->value = value;
            return;
        }
        current = current->next;
    }
}

double get_value(char* name) {
    Entry* current = head;
    while (current != NULL) {
        if (strcmp(current->name, name) == 0)
            return current->value;
        current = current->next;
    }
    return 0.0;
}
