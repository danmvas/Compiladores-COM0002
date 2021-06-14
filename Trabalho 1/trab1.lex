/* Linguagem: Pascal-like */

/* ========================================================================== */
/* Abaixo, indicado pelos limitadores "%{" e "%}", as includes necessárias... */
/* ========================================================================== */

%{
/* Para as funções atoi() e atof() */
#include <math.h>

int num_lines = 1;
int num_colunas = 1;
int id = 0;

%}

/* ========================================================================== */
/* ===========================  Sessão DEFINIÇÔES  ========================== */
/* ========================================================================== */

ID       [a-z_][a-zA-Z0-9]*
DIGITO   [0-9]
INCLUDE  \#include
DEFINE   \#define
BIBLIOTECA <[a-z][a-z]*.h>


/* Adicionar simbolos, tipos, mais operadores (dividir em básicos e complexos), acrescentar tudo, depois dividir em mais tokens para facilitar a criacao da tabela

%%

{DIGITO}+    {
            printf( "Um valor inteiro: %s (%d)\n", yytext,
                    atoi( yytext ) );

                    id++;
            }

{DIGITO}+"."{DIGITO}*        {
            printf( "Um valor real: %s (%g)\n", yytext,
                    atof( yytext ) );,

                    id++;
            }

{BIBLIOTECA} {
        printf( "Uma biblioteca: %s\n", yytext );
        id++;
}

auto|break|else|switch|case|register|typedef|extern|return|continue|for|void|do|if|static|while|default|goto|sizeof|volatile|const|double|int|long|char|signed|struct|enum|union|float|short|unsigned        {
            printf( "Uma palavra-chave: %s\n", yytext );

            id++;
            }

#define{
        printf( "Uma diretiva de definicao: %s\n", yytext );
        id++;
}

#include{
        printf( "Uma diretiva de inclusao: %s\n", yytext );
        id++;
}

{ID}        {
        printf( "Um identificador: %s\n", yytext );
        id++;
}

"+"|"-"|"*"|"/"
        {
                printf( "Um operador: %s\n", yytext );
                id++;
        }
        

"{"[^}\n]*"}"

[ \t]+

\n        ++num_lines;

.           printf( "Caracter não reconhecido: %s\n", yytext );

%%



int main( argc, argv )
int argc;
char **argv;
{
	++argv, --argc;
	if ( argc > 0 )
		yyin = fopen( argv[0], "r" );
	else
		yyin = stdin;

	yylex();
	
	printf("# total de linhas = %d\n", num_lines);
    
	return 0;
}
