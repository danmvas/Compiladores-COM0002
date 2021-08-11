%option noyywrap

%{
#include <stdio.h>
#include <stdbool.h>

#define YY_DECL int yylex()

#include "com.tab.h"

%}

DIGITO		[0-9]+
ID          [a-zA-Z][a-zA-Z0-9]*

%%

"sair"						{return T_QUIT;}
[ \t]	                    ; // ignore todos os espaços em branco

{DIGITO}+\.{DIGITO}+ 		{yylval.fval = atof(yytext); return T_REAL;}
{DIGITO}+					{yylval.ival = atoi(yytext); return T_INT;}
\n							; //{return T_NEWLINE;}
"++"                        {return T_COMPLEXOPERATORPLUS;}
"--"                        {return T_COMPLEXOPERATORMINUS;}
"=="                        {return T_EQUAL;}
">"                         {return T_GREATER;}
">="                        {return T_GREATEREQUAL;}
"<="                        {return T_MINOREQUAL;}
"<"                         {return T_MINOR;}
"!="                        {return T_NOTEQUAL;}
"="                         {return T_ASSING;}
":"                         {return T_TWODOTS;}
"+"|"-"|"*"|"/"             {return T_OPERATOR;}
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
double                      {return T_TYPEDOUBLE;}
int                         {return T_TYPEINT;}
const                       {return T_CONST;}
return                      {return T_RETURN;}
{ID}                        {return T_ID;}
"("							{return T_LEFT;}
")"							{return T_RIGHT;}
"{"                         {return T_LEFTCURLY;}
"}"                         {return T_RIGHTCURLY;}
";"                         {return T_SEMMICOLON;}
.							{printf("Caracter misterioso... %s\n", yytext);}

%%