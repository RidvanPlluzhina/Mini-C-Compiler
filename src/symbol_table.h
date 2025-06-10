#ifndef SYMBOL_TABLE_H  // Header guard to prevent multiple inclusions of this file
#define SYMBOL_TABLE_H

// Inserts a new symbol into the symbol table.
// Parameters:
// - name: the name of the symbol (e.g., variable or identifier).
// - type: the data type of the symbol (e.g., "int", "float").
void insert(char* name, char* type);

// Looks up a symbol by name in the symbol table.
// Returns:
// - the type of the symbol if found; otherwise, NULL.
char* lookup(char* name);

// Sets the value of a symbol.
// Parameters:
// - name: the name of the symbol.
// - value: the numerical value to assign to the symbol.
void set_value(char* name, double value);

// Retrieves the value of a symbol.
// Parameters:
// - name: the name of the symbol.
// Returns:
// - the numerical value associated with the symbol.
double get_value(char* name);

#endif  // End of header guard