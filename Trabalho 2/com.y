%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%union {
	int ival;
	float fval;
}

/* Declaração dos tokens... */
// Arrumar os tokens

%token<ival> T_INT
%token<fval> T_REAL
%token T_PLUS T_MINUS T_MULTIPLY T_DIVIDE T_LEFT T_RIGHT
%token T_NEWLINE T_QUIT
%left T_PLUS T_MINUS
%left T_MULTIPLY T_DIVIDE

%type<ival> expr
%type<fval> mixed_expr

%start calculation

%%

calculation:	/* Aqui temos a representação do epsilon na gramática... */
	| calculation line
	;

// Arrumar linha e expressoes
line: T_NEWLINE
	| mixed_expr T_NEWLINE					{ printf("\tResultado: %f\n", $1);}
	| expr T_NEWLINE							{ printf("\tResultado: %i\n", $1); }
	| T_QUIT T_NEWLINE						{ printf("Até mais...\n"); exit(0); }
	;

mixed_expr: T_REAL							{ $$ = $1; }
	| mixed_expr T_PLUS mixed_expr			{ $$ = $1 + $3; }
	| mixed_expr T_MINUS mixed_expr			{ $$ = $1 - $3; }
	| mixed_expr T_MULTIPLY mixed_expr		{ $$ = $1 * $3; }
	| mixed_expr T_DIVIDE mixed_expr		{ $$ = $1 / $3; }
	| T_LEFT mixed_expr T_RIGHT				{ $$ = $2; }
	| expr T_PLUS mixed_expr				{ $$ = $1 + $3; }
	| expr T_MINUS mixed_expr				{ $$ = $1 - $3; }
	| expr T_MULTIPLY mixed_expr			{ $$ = $1 * $3; }
	| expr T_DIVIDE mixed_expr				{ $$ = $1 / $3; }
	| mixed_expr T_PLUS expr				{ $$ = $1 + $3; }
	| mixed_expr T_MINUS expr				{ $$ = $1 - $3; }
	| mixed_expr T_MULTIPLY expr			{ $$ = $1 * $3; }
	| mixed_expr T_DIVIDE expr				{ $$ = $1 / $3; }
	| expr T_DIVIDE expr					{ $$ = $1 / (float)$3; }
	;

expr: T_INT									{ $$ = $1; }
	| expr T_PLUS expr						{ $$ = $1 + $3; }
	| expr T_MINUS expr						{ $$ = $1 - $3; }
	| expr T_MULTIPLY expr					{ $$ = $1 * $3; }
	| T_LEFT expr T_RIGHT					{ $$ = $2; }
	; // expr tem que terminar com ;

// Talvez mudar as expressões que retornam boolean para um próprio grupo
cond: // Arrumar a parte de fatoração a esquerda pois não tem apenas 1 lookahead
	  T_CONDITIONALIF T_LEFT expr T_RIGHT T_LEFTCURLY line T_RIGHTCURLY T_CONDITIONALELSE T_LEFTCURLY line T_RIGHTCURLY		{}
	| T_CONDITIONALIF T_LEFT expr T_RIGHT T_LEFTCURLY line T_RIGHTCURLY		{}
	| T_CONDITIONALIF T_LEFT expr T_RIGHT expr								{}
	| T_CONDITIONALSWITCH T_LEFT expr T_RIGHT T_LEFTCURLY case T_RIGHTCURLY	{}
	;

case: // Arrumar a parte de fatoração a esquerda pois não tem apenas 1 lookahead
	  T_CONDITIONALCASE expr T_TWODOTS expr									{}
	| T_CONDITIONALCASE expr T_TWODOTS expr case							{}
	| T_CONDITIONALCASE expr T_TWODOTS expr	T_BREAK							{}
	| T_CONDITIONALCASE expr T_TWODOTS expr case T_BREAK					{}
	| T_CONDITIONALDEFAULT expr T_TWODOTS expr								{}
	;

loop: // Arrumar a parte de fatoração a esquerda pois não tem apenas 1 lookahead
	  T_LOOPFOR T_LEFT loopcond T_RIGHT T_LEFTCURLY line T_RIGHTCURLY			{}
	| T_LOOPWHILE T_LEFT expr T_RIGHT T_LEFTCURLY line T_RIGHTCURLY			{}
	| T_LOOPWHILE T_LEFT expr T_RIGHT T_LEFTCURLY line T_RIGHTCURLY			{}
	| T_LOOPDO T_LEFTCURLY line T_RIGHTCURLY T_LOOPWHILE T_LEFT expr T_RIGHT {} // tem que terminar com ;									{}
	;

loopcond:
	// Esse ainda não sei
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
