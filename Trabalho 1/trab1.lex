/* Linguagem: Pascal-like */

/* ========================================================================== */
/* Abaixo, indicado pelos limitadores "%{" e "%}", as includes necessárias... */
/* ========================================================================== */

%{
/* Para as funções atoi() e atof() */
#include <math.h>

int num_linhas = 0;
int num_colunas = 0;
int num_tokens = 0;

    typedef struct token
        {

        int id;
        int linha;
        int coluna;
        char *tipo;
        char descricao[40];

        } token;
    token **tabelaDeSimbolos;   

%}

/* ========================================================================== */
/* ===========================  Sessão DEFINIÇÔES  ========================== */
/* ========================================================================== */

DIGITO   [0-9]
ID       [a-zA-Z][a-zA-Z0-9]*

%%

{DIGITO}+ {
    printf( "Um valor inteiro: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_linhas, num_colunas);

        tabelaDeSimbolos[num_tokens]->id = num_tokens;
        tabelaDeSimbolos[num_tokens]->linha = num_linhas;
        tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
        tabelaDeSimbolos[num_tokens]->tipo = "Inteiro";
        tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
        strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);


    num_colunas += strlen(yytext);
    num_tokens++;
}

{DIGITO}+"."{DIGITO}* {
    printf( "Um valor real: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_linhas, num_colunas);

        tabelaDeSimbolos[num_tokens]->id = num_tokens;
        tabelaDeSimbolos[num_tokens]->linha = num_linhas;
        tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
        tabelaDeSimbolos[num_tokens]->tipo = "Real";
        tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
        strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

    num_colunas += strlen(yytext);
    num_tokens++;
}

auto|register|typedef|extern|static|sizeof {
    printf( "Uma palavra-chave: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_linhas, num_colunas );

        tabelaDeSimbolos[num_tokens]->id = num_tokens;
        tabelaDeSimbolos[num_tokens]->linha = num_linhas;
        tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
        tabelaDeSimbolos[num_tokens]->tipo = "Palavra-chave";
        tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
        strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

    num_colunas += strlen(yytext);
    num_tokens++;
}

break|else|switch|case|return|continue|for|do|if|while|default|goto {
    printf( "Uma palavra-chave de fluxo: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_linhas, num_colunas );

        tabelaDeSimbolos[num_tokens]->id = num_tokens;
        tabelaDeSimbolos[num_tokens]->linha = num_linhas;
        tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
        tabelaDeSimbolos[num_tokens]->tipo = "Fluxo";
        tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
        strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

    num_colunas += strlen(yytext);
    num_tokens++;
}

double|int|char|struct|enum|union|float|void {
    printf( "Uma palavra-chave de tipo de dado: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_linhas, num_colunas );

        tabelaDeSimbolos[num_tokens]->id = num_tokens;
        tabelaDeSimbolos[num_tokens]->linha = num_linhas;
        tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
        tabelaDeSimbolos[num_tokens]->tipo = "Tipo de dado";
        tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
        strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

    num_colunas += strlen(yytext);
    num_tokens++;
}

long|signed|short|unsigned|volatile|const {
    printf( "Uma palavra-chave de modificador de dado: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_linhas, num_colunas );

        tabelaDeSimbolos[num_tokens]->id = num_tokens;
        tabelaDeSimbolos[num_tokens]->linha = num_linhas;
        tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
        tabelaDeSimbolos[num_tokens]->tipo = "Modificador";
        tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
        strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

    num_colunas += strlen(yytext);
    num_tokens++;
}

TRUE|FALSE {
    printf( "Valor booleano: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_linhas, num_colunas );

        tabelaDeSimbolos[num_tokens]->id = num_tokens;
        tabelaDeSimbolos[num_tokens]->linha = num_linhas;
        tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
        tabelaDeSimbolos[num_tokens]->tipo = "Booleano";
        tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
        strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

    num_colunas += strlen(yytext);
    num_tokens++;
}

{ID} {
    printf( "Um identificador: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_linhas, num_colunas );

        tabelaDeSimbolos[num_tokens]->id = num_tokens;
        tabelaDeSimbolos[num_tokens]->linha = num_linhas;
        tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
        tabelaDeSimbolos[num_tokens]->tipo = "Identificador";
        tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
        strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

    num_colunas += strlen(yytext);
    num_tokens++;
}


"?"|"."|","|";"|"`"|"!"|"^"|"~"  {
    printf( "Um símbolo de pontuação: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_linhas, num_colunas );

        tabelaDeSimbolos[num_tokens]->id = num_tokens;
        tabelaDeSimbolos[num_tokens]->linha = num_linhas;
        tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
        tabelaDeSimbolos[num_tokens]->tipo = "Pontuação";
        tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
        strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

    num_colunas += strlen(yytext);
    num_tokens++;
}

"@"|"#"|"&"|":"|"_"|"("|")"|"["|"]"|"{"|"}"|"'"|\" {
    printf( "Outro símbolo: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_linhas, num_colunas );

        tabelaDeSimbolos[num_tokens]->id = num_tokens;
        tabelaDeSimbolos[num_tokens]->linha = num_linhas;
        tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
        tabelaDeSimbolos[num_tokens]->tipo = "Outros símbolos";
        tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
        strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

    num_colunas += strlen(yytext);
    num_tokens++;
}

"+"|"-"|"*"|"/" {
    printf( "Um operador: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_linhas, num_colunas );

        tabelaDeSimbolos[num_tokens]->id = num_tokens;
        tabelaDeSimbolos[num_tokens]->linha = num_linhas;
        tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
        tabelaDeSimbolos[num_tokens]->tipo = "Operador";
        tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
        strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

    num_colunas += strlen(yytext);
    num_tokens++;
}  

"%"|"++"|"--"|"="|"+="|"-="|"*="|"/="|"%="|"=="|">"|"<"|"!="|">="|"<="|"&&"|"||"|"!"|"&"|"^"|"~"|"<<"|">>"|"|"|"?:"|"<<="|">>="|"&="|"^="|"|="|"->" {
    printf( "Outro operador: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_linhas, num_colunas );

        tabelaDeSimbolos[num_tokens]->id = num_tokens;
        tabelaDeSimbolos[num_tokens]->linha = num_linhas;
        tabelaDeSimbolos[num_tokens]->coluna = num_colunas;
        tabelaDeSimbolos[num_tokens]->tipo = "Outro operador";
        tabelaDeSimbolos[num_tokens] = (token *) malloc(sizeof(token));
        strcpy(tabelaDeSimbolos[num_tokens]->descricao, yytext);

    num_colunas += strlen(yytext);
    num_tokens++;
}  

"{"[^}\n]*"}"     /* Lembre-se... comentários não tem utilidade! */

[ ] ++num_colunas;

[ \t]+          /* Lembre-se... espaços em branco não tem utilidade! */

\n {
    ++num_linhas; /* Gera um warning pois não retorna nada */
    num_colunas = 0;

}

.           printf( "Caracter não reconhecido: %s. Encontrado em linha: %d e coluna: %d\n", yytext, num_linhas, num_colunas );

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

    printf("##########################################################################\n");
    tabelaDeSimbolos = (token * *) malloc(sizeof(token*) * 10000);
    num_tokens = 0;
    yylex();
    printf("##########################################################################\n");

    printf("======================TABELA DE SIMBOLOS======================\n");
    printf("ID\t\t DESCRIÇÃO \t\t TIPO\t\t LINHA\t\t COLUNA\n");
    for(int i=0; i<num_tokens; i++) {
        printf("%d\t\t %s\t\t %s\t\t %d\t\t %d\n",
            tabelaDeSimbolos[i]-> id,
            tabelaDeSimbolos[i]-> descricao,
            tabelaDeSimbolos[i]-> tipo,
            tabelaDeSimbolos[i]-> linha,
            tabelaDeSimbolos[i]-> coluna
            );
    }
    
    printf("##########################################################################");
    printf("# total de linhas = %d\n", num_linhas);
    printf("# total de tokens = %d\n", num_tokens);
    
    return 0;
}