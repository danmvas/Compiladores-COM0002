%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "calc.tab.h"

%}

DIGITO		[0-9]+
ID          [a-zA-Z][a-zA-Z0-9]*

%%

[ \t]	                    ; // ignore todos os espaços em branco
"{"[^}\n]*"}"               ; /* Lembre-se... comentários não tem utilidade! */
{DIGITO}+\.{DIGITO}+ 		{yylval.fval = atof(yytext); return T_REAL;}
{DIGITO}+					{yylval.ival = atoi(yytext); return T_INT;}
\n							{return T_NEWLINE;}
"++"|"--"                   {return T_COMPLEXOPERATOR;}
"=="                        {return T_EQUAL;}
"="                         {return T_ASSING;}
"+"|"-"|"*"|"/"             {return T_BASICOPERATOR;}
else|switch|case|if|default {return T_CONDITIONAL;}
break|continue|for|do|while {return T_LOOP;}        // Coloco break aonde?
double|int                  {return T_TYPE;}
return                      {return T_RETURN;}
{ID}                        {return T_ID;}
"("							{return T_LEFT;}
")"							{return T_RIGHT;}
"{"                         {return T_LEFTCURLY;}
"}"                         {return T_RIGHTCURLY;}
[ ]                         {return T_SPACE;}
"sair"						{return T_QUIT;}
.							{printf("Caracter misterioso... %s\n", yytext);}

%%