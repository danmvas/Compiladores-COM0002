%{

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%union {
	int ival;
	float fval;
	bool bval;
}

/* Declaração dos tokens... */

%token<ival> T_INT
%token<fval> T_REAL
%token T_NEWLINE T_QUIT
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LEFT T_RIGHT
%token T_ID T_ASSING T_COMPLEXOPERATORPLUS T_COMPLEXOPERATORMINUS
%token T_CONDITIONALIF T_RIGHTCURLY T_LEFTCURLY T_CONDITIONALELSE
%token T_CONDITIONALSWITCH T_CONDITIONALCASE T_TWODOTS T_CONDITIONALDEFAULT
%token T_LOOPFOR T_LOOPWHILE T_LOOPDO T_BREAK T_EQUAL T_SEMMICOLON
%token T_LOOPCONTINUE T_TYPEDOUBLE T_TYPEINT T_RETURN T_SPACE
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE

%start calculation

%%

calculation:	/* Aqui temos a representação do epsilon na gramática... */
	| calculation line
	;

line: T_NEWLINE
	| T_QUIT T_NEWLINE						{ printf("Até mais...\n"); exit(0); }
	| mixed_expr T_NEWLINE					
	| expr T_NEWLINE						
	| bool_expr T_NEWLINE					
	| assing_expr T_NEWLINE					
	| cond T_NEWLINE						
	| case T_NEWLINE						
	| loop T_NEWLINE						 
	;

mixed_expr: T_REAL							{ }
	| mixed_expr T_PLUS mixed_expr			{ }
	| mixed_expr T_MINUS mixed_expr			{ }
	| mixed_expr T_MULTIPLY mixed_expr		{ }
	| mixed_expr T_DIVIDE mixed_expr		{ }
	| T_LEFT mixed_expr T_RIGHT				{ }
	| expr T_PLUS mixed_expr				{ }
	| expr T_MINUS mixed_expr				{ }
	| expr T_MULTIPLY mixed_expr			{ }
	| expr T_DIVIDE mixed_expr				{ }
	| mixed_expr T_PLUS expr				{ }
	| mixed_expr T_MINUS expr				{ }
	| mixed_expr T_MULTIPLY expr			{ }
	| mixed_expr T_DIVIDE expr				{ }
	| expr T_DIVIDE expr					{ }
	;

expr: T_INT									{ }
	| expr T_PLUS expr						{ }
	| expr T_MINUS expr						{ }
	| expr T_MULTIPLY expr					{ }
	| T_LEFT expr T_RIGHT					{ }
	; 

bool_expr: T_ID bool_expr_linha				{ }
	;

bool_expr_linha: 							{ } // vazio
	| T_EQUAL bool_expr_2linha				{ }
	;

bool_expr_2linha: T_ID						{ }
	| expr						    		{ }
	| mixed_expr				    		{ }
	;

assing_expr: T_ID assing_expr_linha			{ }
	| T_TYPEINT T_ID assing_expr_3linha		{ }
	| T_TYPEDOUBLE T_ID assing_expr_3linha	{ }
	;

assing_expr_linha: assing_expr_3linha					{ }
	| T_COMPLEXOPERATORPLUS								{ }
	| T_COMPLEXOPERATORMINUS							{ }
	;

assing_expr_2linha: expr	{ }
	| mixed_expr			{ }
	;

assing_expr_3linha: T_ASSING assing_expr_2linha			{ }
	;

cond: T_CONDITIONALIF T_LEFT bool_expr T_RIGHT cond_linha				    { }
	| T_CONDITIONALSWITCH T_LEFT T_ID T_RIGHT T_LEFTCURLY case T_RIGHTCURLY { }
	;

cond_linha: T_LEFTCURLY line T_RIGHTCURLY cond_2linha		{ }
	| expr													{ }
	| mixed_expr											{ }
	| assing_expr											{ }
	;

cond_2linha: 											{ } // vazio
	| T_CONDITIONALELSE T_LEFTCURLY line T_RIGHTCURLY	{ }
	;

case: T_CONDITIONALCASE expr T_TWODOTS expr	case_linha						{ }
	| T_CONDITIONALDEFAULT T_TWODOTS expr									{ }
	;

case_linha:							{ } // vazio
	| case							{ }
	| T_BREAK						{ }
	| case T_BREAK					{ }
	;

loop: T_LOOPFOR T_LEFT loopcond T_RIGHT T_LEFTCURLY line T_RIGHTCURLY				{ }
	| T_LOOPWHILE T_LEFT bool_expr T_RIGHT T_LEFTCURLY line T_RIGHTCURLY			{ }
	| T_LOOPDO T_LEFTCURLY line T_RIGHTCURLY T_LOOPWHILE T_LEFT bool_expr T_RIGHT 	{ }
	;

loopcond: assing_expr T_SEMMICOLON cond T_SEMMICOLON loopcond_linha { }
	;

loopcond_linha: expr    { }
	| mixed_expr 		{ }
	;

%%

int main() {
	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Erro de análise (sintática): %s\n", s);
	exit(1);
}
