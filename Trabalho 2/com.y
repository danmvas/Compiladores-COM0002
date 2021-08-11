%{

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <graphviz>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%define parse.lac full
%define parse.error verbose

%union {
	int ival;
	float fval;
	bool bval;
}

/* Declaração dos tokens... */

%token<ival> T_INT
%token<fval> T_REAL
%token T_QUIT
%token T_OPERATOR T_LEFT T_RIGHT
%token T_ID T_ASSING T_COMPLEXOPERATORPLUS T_COMPLEXOPERATORMINUS
%token T_CONDITIONALIF T_RIGHTCURLY T_LEFTCURLY T_CONDITIONALELSE
%token T_CONDITIONALSWITCH T_CONDITIONALCASE T_TWODOTS T_CONDITIONALDEFAULT
%token T_LOOPFOR T_LOOPWHILE T_LOOPDO T_BREAK T_EQUAL T_SEMMICOLON
%token T_LOOPCONTINUE T_TYPEDOUBLE T_TYPEINT T_RETURN T_CONST
%token T_GREATER T_GREATEREQUAL T_MINOREQUAL T_MINOR T_NOTEQUAL

%start calculation

%%

calculation:	/* Aqui temos a representação do epsilon na gramática... */
	| calculation line
	;

line: T_QUIT 						{ printf("Até mais...\n"); exit(0); }
	| math_expr T_SEMMICOLON														
	| assing_expr 					
	| cond 												
	| loop 						 
	;

math_expr: T_INT							{ printf("Inteiro: \n"); } // printar a árvore
	| T_REAL								{ printf("Real: \n"); } // printar a árvore
	| math_expr T_OPERATOR math_expr		{ printf("Operação básica: \n"); } // printar a árvore
	| T_LEFT math_expr T_RIGHT				{ printf("Parenteses: \n"); } // printar a árvore
	;	

bool_expr: T_ID bool_expr_linha				
	;

bool_expr_linha: 							 // vazio
	| T_EQUAL bool_expr_2linha	
	| T_GREATER bool_expr_2linha	
	| T_GREATEREQUAL bool_expr_2linha	
	| T_MINOREQUAL bool_expr_2linha			
	| T_MINOR bool_expr_2linha	
	| T_NOTEQUAL bool_expr_2linha	
	;

bool_expr_2linha: T_ID						
	| math_expr						    					    		
	;

assing_expr: T_ID assing_expr_linha	T_SEMMICOLON		{ printf("Atribuição de valor: \n"); } // printar a árvore
	| T_TYPEINT T_ID assing_expr_2linha	T_SEMMICOLON	{ printf("Declaração de variável int: \n"); } // printar a árvore
	| T_TYPEDOUBLE T_ID assing_expr_2linha T_SEMMICOLON	{ printf("Declaração de variável double: \n"); } // printar a árvore
	| T_CONST assing_expr_3linha T_SEMMICOLON			{ printf("Declaração de constante: \n"); } // printar a árvore
	;

assing_expr_linha: assing_expr_2linha					
	| T_COMPLEXOPERATORPLUS								
	| T_COMPLEXOPERATORMINUS							
	;

assing_expr_2linha: T_ASSING math_expr			
	;

assing_expr_3linha: T_TYPEINT T_ID assing_expr_2linha
	| T_TYPEDOUBLE T_ID assing_expr_2linha
	;

cond: T_CONDITIONALIF T_LEFT bool_expr T_RIGHT cond_linha				    			 { printf("If: \n"); } // printar a árvore
	| T_CONDITIONALSWITCH T_LEFT T_ID T_RIGHT T_LEFTCURLY case case_default T_RIGHTCURLY { printf("Switch: \n"); } // printar a árvore
	;

cond_linha: T_LEFTCURLY line T_RIGHTCURLY cond_2linha		
	| math_expr																							
	| assing_expr											
	;

cond_2linha: 											 // vazio
	| T_CONDITIONALELSE T_LEFTCURLY line T_RIGHTCURLY	
	;

case: T_CONDITIONALCASE math_expr T_TWODOTS line case_linha	
	;					

case_default: T_CONDITIONALDEFAULT T_TWODOTS line									
	;

case_linha:							 // vazio
	| case							
	| T_BREAK T_SEMMICOLON									
	;

loop: T_LOOPFOR T_LEFT loopcond T_RIGHT T_LEFTCURLY line T_RIGHTCURLY							{ printf("Loop for: \n"); } // printar a árvore
	| T_LOOPWHILE T_LEFT bool_expr T_RIGHT T_LEFTCURLY line T_RIGHTCURLY						{ printf("Loop while: \n"); } // printar a árvore
	| T_LOOPDO T_LEFTCURLY line T_RIGHTCURLY T_LOOPWHILE T_LEFT bool_expr T_RIGHT T_SEMMICOLON 	{ printf("Loop do while: \n"); } // printar a árvore
	;

loopcond: assing_expr bool_expr T_SEMMICOLON T_ID assing_expr_linha 
	;

%%

int main( argc, argv )
int argc;
char **argv;
{
	++argv, --argc;
	if ( argc > 0 )
        yyin = fopen( argv[0], "r" );
    else {
		yyin = stdin;

		do {
			yyparse();
		} while(!feof(yyin));
	}

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Erro de análise (sintática): %s\n", s);
	exit(1);
}
