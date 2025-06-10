%{
#include <stdio.h>           // Standard I/O
#include <stdlib.h>          // For memory and math functions
#include <string.h>          // For string comparison
#include "symbol_table.h"   // Custom symbol table interface

// Function declarations
void yyerror(const char *s); // Error reporting function
int yylex(void);             // Lexical analyzer function
%}

/* Define value types for tokens and nonterminals */
%union {
  char* lexeme;    // For identifiers
  double value;    // For numeric values
}

/* Tokens with associated types */
%token <value> NUM         // Numeric literals
%token <lexeme> ID         // Identifiers
%token INT_TYPE FLOAT_TYPE // Keywords
%token IF                  // "if" keyword

/* Non-terminal with associated type */
%type <value> expr

/* Start symbol for the grammar */
%start program

%%

/* Grammar rules */

program:
      program stmt         // A program is a sequence of statements
    | /* empty */          // Or it can be empty
    ;

stmt:
      decl ';'             // Declaration statement
    | assign ';'           // Assignment statement
    ;

decl:
      INT_TYPE ID          { insert($2, "int"); }       // Declare integer variable
    | FLOAT_TYPE ID        { insert($2, "float"); }     // Declare float variable
    ;

assign:
      ID '=' expr {
        // Assignment with type checking
        char* type = lookup($1);
        if (type == NULL) {
            printf("Error: Undeclared variable %s\n", $1);
        } else if (strcmp(type, "int") == 0 && $3 != (int)$3) {
            // Warn if assigning float to int
            printf("Type error: assigning float to int variable %s\n", $1);
        } else {
            // Valid assignment
            set_value($1, $3);
            printf("Assignment OK: %s = %f\n", $1, $3);
        }
      }
    ;

expr:
      expr '+' expr   { $$ = $1 + $3; }   // Addition
    | expr '-' expr   { $$ = $1 - $3; }   // Subtraction
    | expr '*' expr   { $$ = $1 * $3; }   // Multiplication
    | expr '/' expr   { $$ = $1 / $3; }   // Division
    | NUM             { $$ = $1; }        // Numeric literal
    | ID              { $$ = get_value($1); }  // Retrieve variable value
    ;

%%

/* Main function: triggers parsing */
int main() {
    return yyparse();  // Start parsing
}

/* Error reporting function */
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}