%{
	#include "com.tab.h"
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	int lineCounter = 1;

	extern int printLineNumber(int num);
%}
letter  [a-zA-Z]
digit [0-9]
digits {digit}+
id {letter}({letter}|{digit})*
num "-"?{digits}
fnum "-"?{digits}.{digits}("E"{digits}+)?
relop "=="|"!="|">"|">="|"<"|"<="
boolop "&&"|"||"
op "+"|"-"|"*"|"/"|"%"|"&"|"|"
binary "true"|"false"
%%
"print"	{return SYSTEM_OUT;}
"int"	{return INT_WORD;}
"float"	{return FLOAT_WORD;}
{num}	{yylval.ival = atoi(yytext); return INT;}
{fnum}	{yylval.fval = atof(yytext); return FLOAT;}
{id}	{yylval.idval = strdup(yytext);return IDENTIFIER;}
";" { return SEMI_COLON;}
"=" {return EQUALS;}
"(" { return LEFT_BRACKET;}
")" {return RIGHT_BRACKET;}
\n	{++lineCounter;	printLineNumber(lineCounter);}
%%


int yywrap() {
   // open next reference or source file and start scanning
   return -1;
}

/*
main()
{
	yylex();
}
*/