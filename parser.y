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

%token <value> NUM
%token <lexeme> ID
%token INT_TYPE FLOAT_TYPE
%token IF
%type <value> expr
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
      INT_TYPE ID    { insert($2, "int"); }
    | FLOAT_TYPE ID  { insert($2, "float"); }
    ;

assign:
      ID '=' expr     {
                        char* type = lookup($1);
                        if (type == NULL) {
                            printf("Error: Undeclared variable %s\n", $1);
                        } else if (strcmp(type, "int") == 0 && $3 != (int)$3) {
                            printf("Type error: assigning float to int variable %s\n", $1);
                        } else {
                            printf("Assignment OK: %s = %f\n", $1, $3);
                        }
                      }
    ;

expr:
      expr '+' expr   { $$ = $1 + $3; }
    | expr '-' expr   { $$ = $1 - $3; }
    | expr '*' expr   { $$ = $1 * $3; }
    | expr '/' expr   { $$ = $1 / $3; }
    | NUM             { $$ = $1; }
    | ID              { $$ = 0; }
    ;

%%

int main() {
    return yyparse();
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}
