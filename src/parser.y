%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symbol_table.h"

void yyerror(const char *s);
int yylex(void);
%}

%union {
  char* lexeme;
  double value;
}

/* Tokens */
%token <value> NUM
%token <lexeme> ID
%token INT_TYPE FLOAT_TYPE IF

/* Operator precedence (FIX FOR CONFLICTS) */
%left '+' '-'
%left '*' '/'
%nonassoc UMINUS

/* Non-terminals */
%type <value> expr term factor

%start program

%%

program:
    program stmt
    | /* empty */
    ;

stmt:
    decl ';'
    | assign ';'
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
        char* type = lookup($1);
        if (!type) {
            printf("Error: Undeclared variable %s\n", $1);
        } else if (strcmp(type, "int") == 0 && $3 != (int)$3) {
            printf("Warning: Implicit float-to-int conversion for %s\n", $1);
            set_value($1, (int)$3);
        } else {
            set_value($1, $3);
        }
    }
    ;

/* Hierarchical expressions (FIX FOR CONFLICTS) */
expr:
    expr '+' term { $$ = $1 + $3; }
    | expr '-' term { $$ = $1 - $3; }
    | term { $$ = $1; }
    ;

term:
    term '*' factor { $$ = $1 * $3; }
    | term '/' factor { $$ = $1 / $3; }
    | factor { $$ = $1; }
    ;

factor:
    NUM { $$ = $1; }
    | ID { $$ = get_value($1); }
    | '(' expr ')' { $$ = $2; }
    ;

%%

int main() {
    return yyparse();
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}