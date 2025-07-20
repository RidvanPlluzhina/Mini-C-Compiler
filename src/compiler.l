%option noyywrap

%{
#include "typed_val.h"
#include "symbol_table.h"
#include "parser.tab.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

/* this is to define ERROR token if not already defined*/
#ifndef ERROR
#define ERROR 256
#endif
%}

DIGIT    [0-9]
NUM      {DIGIT}+(\.{DIGIT}+)?
LETTER   [a-zA-Z]
ID       {LETTER}({LETTER}|{DIGIT})*

%%
    /* Rules Section */

[ \t\r\n]+        { /* Skip whitespace */ }

    /* Comments */
"//"[^\n]*        { /* Skip single-line */ }
"/*"([^*]|\*+[^*/])*"*/" { /* Skip multi-line */ }

    /* Keywords */
"int"             { return INT_TYPE; }
"float"           { return FLOAT_TYPE; }
"if"|"IF"         { return IF; }
"while"|"WHILE"   { return WHILE; }

    /* Numbers */
{NUM}             { 
    yylval.value = atof(yytext); 
    return NUM; 
}

    /* Identifiers */
{ID}              { 
    yylval.lexeme = strdup(yytext); 
    return ID; 
}

    /* Operators */
[+\-*/=;(),{}]    { return yytext[0]; }

    /* Error handling */
.                 { 
    fprintf(stderr, "Lexical error: Invalid character '%s'\n", yytext); 
    return ERROR; 
}

%%


