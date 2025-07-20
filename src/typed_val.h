#ifndef TYPED_VAL_H
#define TYPED_VAL_H

typedef struct {
    double val;       // used for storing float or int values
    char* type;       // "int" or "float"
} typed_val;

#endif
