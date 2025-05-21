#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include "symbol_table.h"

typedef struct entry {
    char* name;
    char* type;
    struct entry* next;
} Entry;

Entry* head = NULL;

void insert(char* name, char* type) {
    Entry* e = malloc(sizeof(Entry));
    e->name = strdup(name);
    e->type = strdup(type);
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
