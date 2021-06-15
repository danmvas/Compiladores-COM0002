/* Linguagem: Pascal-like */

/* ========================================================================== */
/* Abaixo, indicado pelos limitadores "%{" e "%}", as includes necessárias... */
/* ========================================================================== */

%{
/* Para as funções atoi() e atof() */
#include <math.h>

int num_lines = 0;
int num_columns = 0;
int tokens = 0;
%}

/* ========================================================================== */
/* ===========================  Sessão DEFINIÇÔES  ========================== */
/* ========================================================================== */

DIGITO   [0-9]
ID       [a-zA-Z][a-zA-Z0-9]*
INCLUSAO  #include
DEFINICAO   #define
BIBLIOTECA <[a-z][a-z]*.h>

%%

{DIGITO}+ {
    printf( "Um valor inteiro: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_lines, num_columns);
    num_columns += strlen(yytext);
    tokens++;
}

{DIGITO}+"."{DIGITO}* {
    printf( "Um valor real: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_lines, num_columns);
    num_columns += strlen(yytext);
    tokens++;
}

{BIBLIOTECA} {
    printf( "Uma biblioteca: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_lines, num_columns );
    num_columns += strlen(yytext);
    tokens++;
}

auto|register|typedef|extern|static|sizeof {
    printf( "Uma palavra-chave: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_lines, num_columns );
    num_columns += strlen(yytext);
    tokens++;
}

break|else|switch|case|return|continue|for|do|if|while|default|goto {
    printf( "Uma palavra-chave de fluxo: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_lines, num_columns );
    num_columns += strlen(yytext);
    tokens++;
}

double|int|char|struct|enum|union|float|void {
    printf( "Uma palavra-chave de tipo de dado: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_lines, num_columns );
    num_columns += strlen(yytext);
    tokens++;
}

long|signed|short|unsigned|volatile|const {
    printf( "Uma palavra-chave de modificador de dado: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_lines, num_columns );
    num_columns += strlen(yytext);
    tokens++;
}

TRUE|FALSE {
    printf( "Valor booleano: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_lines, num_columns );
    num_columns += strlen(yytext);
    tokens++;
}

{DEFINICAO} {
    printf( "Uma diretiva de definição: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_lines, num_columns );
    num_columns += strlen(yytext);
    tokens++;
}

{INCLUSAO} {
    printf( "Uma diretiva de inclusão: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_lines, num_columns );
    num_columns += strlen(yytext);
    tokens++;
}

{ID} {
    printf( "Um identificador: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_lines, num_columns );
    num_columns += strlen(yytext);
    tokens++;
}


"?"|"."|","|";"|"`"|"!"|"^"|"~"  {
    printf( "Um símbolo de pontuação: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_lines, num_columns );
    num_columns += strlen(yytext);
    tokens++;
}

"@"|"#"|"&"|":"|"_"|"("|")"|"["|"]"|"{"|"}"|"'"|\" {
    printf( "Outro símbolo: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_lines, num_columns );
    num_columns += strlen(yytext);
    tokens++;
}

"+"|"-"|"*"|"/" {
    printf( "Um operador: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_lines, num_columns );
    num_columns += strlen(yytext);
    tokens++;
}  

"%"|"++"|"--"|"="|"+="|"-="|"*="|"/="|"%="|"=="|">"|"<"|"!="|">="|"<="|"&&"|"||"|"!"|"&"|"^"|"~"|"<<"|">>"|"|"|"?:"|"<<="|">>="|"&="|"^="|"|="|"->" {
    printf( "Outro operador: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_lines, num_columns );
    num_columns += strlen(yytext);
    tokens++;
}  

"{"[^}\n]*"}"     /* Lembre-se... comentários não tem utilidade! */

[ ] ++num_columns;

[ \t]+          /* Lembre-se... espaços em branco não tem utilidade! */

\n {
    ++num_lines; /* Gera um warning pois não retorna nada */
    num_columns = 0;

}

.           printf( "Caracter não reconhecido: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_lines, num_columns );

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
    printf("# total de tokens = %d\n", tokens);
    
    return 0;
}