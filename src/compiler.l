%option noyywrap

%{
#include "parser.tab.h"
#include <stdlib.h>
#include <string.h>
%}

DIGIT    [0-9]
NUM      {DIGIT}+(\.{DIGIT}+)?
LETTER   [a-zA-Z]
ID       {LETTER}+

%%
"//"[^\n]*     { /* Skip comments */ }

"int"          { return INT_TYPE; }
"float"        { return FLOAT_TYPE; }
"if"|"IF"      { return IF; }

{NUM}          { yylval.value = atof(yytext); return NUM; }
{ID}           { yylval.lexeme = strdup(yytext); return ID; }

[+\-*/=;()]    { return yytext[0]; }  /* Operators and punctuation */
[ \t\n]        { /* Ignore whitespace */ }
.              { printf("Invalid character: %s\n", yytext); }

%%