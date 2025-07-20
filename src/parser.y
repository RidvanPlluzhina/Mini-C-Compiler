%{

#include "typed_val.h"
#include "symbol_table.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


void yyerror(const char *s);
int yylex(void);


%}
%union {
    char* lexeme;
    double value;
    typed_val typed_val; 
}

/* Tokens */
%token <value> NUM
%token <lexeme> ID
%token INT_TYPE FLOAT_TYPE IF WHILE

/* Operator precedence */
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

/* Non-terminals - ONLY type those that return values */
%type <typed_val> expr term factor  // Expressions return values
/* stmt/stmt_list DON'T need types - removed %type */

%start program

%% 

program:
    program stmt
    | /* empty */
    ;

stmt:
    decl ';'
    | assign ';'
    | IF '(' expr ')' stmt
    | WHILE '(' expr ')' stmt
    | '{' { push_scope(); } stmt_list '}' { pop_scope(); }
    ;

stmt_list:
    stmt stmt_list
    | /* empty */   // No warning now - no type expected
    ;

decl:
    INT_TYPE ID {
        if (lookup($2)) {
            printf("Error: Variable %s already declared\n", $2);
        } else {
            insert($2, "int");
        }
    }
    | FLOAT_TYPE ID {
        if (lookup($2)) {
            printf("Error: Variable %s already declared\n", $2);
        } else {
            insert($2, "float");
        }
    }
    ;

assign:
    ID '=' expr {
        Entry* entry = lookup($1);  // Use the full symbol table entry
        if (!entry) {
            printf("Error: Undeclared variable %s\n", $1);
        } else if (strcmp(entry->type, "int") == 0 && strcmp($3.type, "float") == 0) {
            printf("Warning: Implicit float-to-int conversion for %s\n", $1);
            entry->value.int_val = (int)$3.val;
        } else if (strcmp(entry->type, $3.type) != 0) {
            printf("Error: Type mismatch in assignment for %s\n", $1);
        } else {
            if (strcmp(entry->type, "int") == 0)
                entry->value.int_val = (int)$3.val;
            else if (strcmp(entry->type, "float") == 0)
                entry->value.float_val = (float)$3.val;
        }
    }
    ;

expr:
    expr '+' term { 
        $$ = (typed_val){ .val = $1.val + $3.val, .type = "float" }; 
    }
    | expr '-' term { 
        $$ = (typed_val){ .val = $1.val - $3.val, .type = "float" }; 
    }
    | term { 
        $$ = $1; 
    }
    ;

term:
    term '*' factor { 
        $$ = (typed_val){ .val = $1.val * $3.val, .type = "float" }; 
    }
    | term '/' factor { 
        $$ = (typed_val){ .val = $1.val / $3.val, .type = "float" }; 
    }
    | factor { 
        $$ = $1; 
    }
    ;

factor:
    NUM { 
        $$ = (typed_val){ .val = $1, .type = "float" }; 
    }
    | ID { 
        $$ = get_value($1); 
    }
    | '(' expr ')' { 
        $$ = $2; 
    }
    ;

%% 

int main() {
    return yyparse();
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}