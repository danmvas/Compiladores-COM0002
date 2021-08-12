%option noyywrap

%{
#include <stdio.h>
#include <stdbool.h>
#include <math.h>

#define YY_DECL int yylex()

#include "com.tab.h"

int num_linhas = 0;
int num_colunas = 0;
int num_tokens = 0;
typedef struct token
    {

    int id;
    int linha;
    int coluna;
    char *tipo;
    char descricao[100];

    } token;
token *tabelaDeSimbolos[10000]; 

%}

DIGITO		[0-9]+
ID          [a-zA-Z][a-zA-Z0-9]*

%%

"sair"						{ return T_QUIT; }
[ \t]	                    ; // ignore todos os espaços em branco
\/\/[^\n\r]+?([\n\r])       ; // ignore o comentário de uma linha
{DIGITO}+\.{DIGITO}+ 		{
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_REAL";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                yylval.fval = atof(yytext); 
                                return T_REAL;
                            }
{DIGITO}+					{
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_INT";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                yylval.ival = atoi(yytext); 
                                return T_INT;
                            }
\n							{
                                ++num_linhas; /* Gera um warning pois não retorna nada */
                                num_colunas = 0;
                            }
"++"                        {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_COMPLEXOPERATORPLUS";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_COMPLEXOPERATORPLUS;
                            }
"--"                        {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_COMPLEXOPERATORMINUS";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_COMPLEXOPERATORMINUS;
                            }
"=="                        {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_EQUAL";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_EQUAL;
                            }
">"                         {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_GREATER";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_GREATER;
                            }
">="                        {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_GREATEREQUAL";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_GREATEREQUAL;
                            }
"<="                        {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_MINOREQUAL";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_MINOREQUAL;
                            }
"<"                         {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_MINOR";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_MINOR;
                            }
"!="                        {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_NOTEQUAL";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_NOTEQUAL;
                            }
"="                         {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_ASSING";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_ASSING;
                            }
":"                         {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_TWODOTS";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_TWODOTS;
                            }
"+"|"-"|"*"|"/"             {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_OPERATOR";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_OPERATOR;
                            }
if                          {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_CONDITIONALIF";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_CONDITIONALIF;
                            }
else                        {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_CONDITIONALELSE";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_CONDITIONALELSE;
                            }
switch                      {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_CONDITIONALSWITCH";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_CONDITIONALSWITCH;
                            }
case                        {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_CONDITIONALCASE";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_CONDITIONALCASE;
                            }
default                     {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_CONDITIONALDEFAULT";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_CONDITIONALDEFAULT;
                            }
for                         {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_LOOPFOR";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_LOOPFOR;}   

continue                    {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_LOOPCONTINUE";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_LOOPCONTINUE;
                            }
do                          {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_LOOPDO";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_LOOPDO;
                            }
while                       {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_LOOPWHILE";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_LOOPWHILE;
                            }
break                       {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_BREAK";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_BREAK;
                            } 

double                      {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_TYPEDOUBLE";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_TYPEDOUBLE;
                            }
int                         {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_TYPEINT";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_TYPEINT;
                            }
const                       {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_CONST";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_CONST;
                            }
return                      {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_RETURN";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_RETURN;
                            }
{ID}                        {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_ID";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_ID;
                            }
"("							{
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_LEFT";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_LEFT;
                            }
")"							{
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_RIGHT";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_RIGHT;
                            }
"{"                         {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_LEFTCURLY";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_LEFTCURLY;
                            }
"}"                         {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_RIGHTCURLY";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_RIGHTCURLY;
                            }
";"                         {
                                tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
                                tabelaDeSimbolos[num_tokens]->id = num_tokens;
                                tabelaDeSimbolos[num_tokens]->linha = num_linhas;
                                tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
                                tabelaDeSimbolos[num_tokens]->tipo = "T_SEMMICOLON";
                                strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

                                num_colunas += strlen(yytext);
                                num_tokens++;
                                return T_SEMMICOLON;
                            }
[ ]                         ++num_colunas;
.							printf( "Caracter não reconhecido: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_linhas, num_colunas );

%%