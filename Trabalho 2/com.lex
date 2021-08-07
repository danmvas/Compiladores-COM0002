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
":"                         {return T_TWODOTS;}
"+"|"-"|"*"|"/"             {return T_BASICOPERATOR;}
if                          {return T_CONDITIONALIF;}
else                        {return T_CONDITIONALELSE;}
switch                      {return T_CONDITIONALSWITCH;}
case                        {return T_CONDITIONALCASE;}
default                     {return T_CONDITIONALDEFAULT;}
for                         {return T_LOOPFOR;}    
continue                    {return T_LOOPCONTINUE;}
do                          {return T_LOOPDO;}
while                       {return T_LOOPWHILE;}
break                       {return T_BREAK;}  
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