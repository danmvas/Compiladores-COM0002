%option noyywrap

%{
	#include "com.tab.h"
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include <math.h>

	#define YY_DECL int yylex()

	int lineCounter = 1;

	extern int printLineNumber(int num);
%}

LETRA  [a-zA-Z]
DIGITO [0-9]
DIGITOS {DIGITO}+
ID {LETRA}({LETRA}|{DIGITO})*
INT "-"?{DIGITOS}
DOUBLE "-"?{DIGITOS}.{DIGITOS}("E"{DIGITOS}+)?
OPERATOR "+"|"-"|"*"|"/"|"%"|"&"|"|"
BOOLEAN "true"|"false"
RELATIONALOP "=="|"!="|">"|">="|"<"|"<="
BOOLEANOP "&&"|"||"

%%
[ \t]	                    ; // ignore todos os espaços em branco
\/\/[^\n\r]+?([\n\r])       ; // ignore o comentário de uma linha
"print"						{ return SYSTEM_OUT; }
"int"						{ return T_TYPEINT; }
"double"					{ return T_TYPEDOUBLE; }
"boolean" 					{ return T_TYPEBOOLEAN; }
"const"						{ return T_CONST; }
"if"						{ return T_CONDITIONALIF; }
"else"						{ return T_CONDITIONALELSE; }
"while"						{ return T_LOOPWHILE; }
"for"						{ return T_LOOPFOR; }
"do"						{ return T_LOOPDO; }
"switch"					{ return T_CONDITIONALSWITCH; }
"case"						{ return T_CONDITIONALCASE; }
"break"						{ return T_BREAK; }
"default"					{ return T_CONDITIONALDEFAULT; }
{INT}						{ yylval.ival = atoi(yytext); return T_INT; }
{DOUBLE}					{ yylval.fval = atof(yytext); return T_REAL; }
"++"						{ return T_COMPLEXOPERATORPLUS; }
"--"						{ return T_COMPLEXOPERATORMINUS; }
{OPERATOR}					{ yylval.aopval = strdup(yytext); return T_ARITH_OP; }
{RELATIONALOP} 				{ yylval.aopval = strdup(yytext); return T_RELA_OP; }
{BOOLEANOP} 				{ yylval.aopval = strdup(yytext); return T_BOOL_OP; }
{BOOLEAN} 					{ if(!strcmp(yytext,"true")){ yylval.bval = 1;} else { yylval.bval = 0; } return T_BOOL; }
{ID}						{ yylval.idval = strdup(yytext);return T_ID; }
":"							{ return T_TWODOTS; }
";" 						{ return T_SEMICOLON; }
"=" 						{ return T_ASSING; }
"(" 						{ return T_LEFTBRACKET; }
")" 						{ return T_RIGHTBRACKET; }
"{" 						{ return T_LEFTCURLY; }
"}" 						{ return T_RIGHTCURLY ;}
\n							{ ++lineCounter;	printLineNumber(lineCounter); }
.							printf( "Caracter não reconhecido: %s. Encontrado em linha: %d e coluna: %d\n", yytext, 1, 1 );
%%
