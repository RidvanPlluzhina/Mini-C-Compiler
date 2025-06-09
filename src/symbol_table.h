#ifndef SYMBOL_TABLE_H
#define SYMBOL_TABLE_H

void insert(char* name, char* type);
char* lookup(char* name);
void set_value(char* name, double value);
double get_value(char* name);

#endif
