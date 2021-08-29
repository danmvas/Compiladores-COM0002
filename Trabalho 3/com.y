%{
// imports necessários
#include <fstream>
#include <iostream>
#include <map>
#include <cstring>
#include <vector>
#include <stdio.h>
#include <unistd.h>

#include "bytecode_inst.h"

#define GetCurrentDir getcwd

using namespace std;

// imports do lex
extern  int yylex();
extern  FILE *yyin;
void yyerror(const char * s);
extern int contLinha;

#define TRUE 1
#define FALSE 0
string outfileName ;

// Nome do arquivo gerado
ofstream fout("output.j");	
// Função que gera o header
void generateHeader(void);	
// Função que gera o footer
void generateFooter(void);	

// Quantidade de variáveis
int variableQtd = 1; 
// Quantidade de labels
int labelsQtd = 0;

// Definição de um enum de tipos
typedef enum {INT_T, FLOAT_T, BOOL_T, VOID_T, ERROR_T} type_enum;

// Definição da tabela de simbolos
map<string, pair<int,type_enum> > tabelaSimbolos;

// Verifica se uma variável existe
bool checkVar(string id);

// Retorna o bytecode do operador
string getOperator(string op);

// Cria uma variável
void defininicaoVar(string name, int type);

// Aplica a função matemática
void operacaoMatematica(int from , int to, string op);

// Gera uma nova label
string geraLabel();
// Retorna a label passada
string getLabel(int n);

// Escreve na lista
void remendaComLabel(vector<int> *list, int num);

// Função que une duas listas
vector<int> * mergeLists (vector<int> *list1, vector<int>* list2);

// Lista do que será escrito
vector<string> listaCodigo;

// Escreve na lista
void escreveCodigo(string x);

// Salva no output
void printCodigo(void);

// Cada linha do input deve ter isso
void escreveLinha(int num)
{
	escreveCodigo(".line "+ to_string(num));
}

%}

// Bison com verbose
%define parse.lac full
%define parse.error verbose

%code requires {
	#include <vector>
	using namespace std;
}

// Símbolo inicial
%start inicio

// Union dos tipos utilizados
%union{
	int ival;
	float fval;
	int bval;
	char * idval;
	char * aopval;
	struct {
		int sType;
	} expr_type;
	struct {
		vector<int> *trueList, *falseList;
	} bexpr_type;
	struct {
		vector<int> *nextList;
	} stmt_type;
	int sType;
}

// Definição de tokens
%token <ival> T_INT
%token <fval> T_REAL
%token <bval> T_BOOL

%token <idval> T_ID

%token <aopval> T_ARITH_OP
%token <aopval> T_RELA_OP
%token <aopval> T_BOOL_OP

%token T_TYPEINT
%token T_TYPEDOUBLE
%token T_TYPEBOOLEAN
%token T_CONST

%token T_SEMICOLON
%token T_ASSING
%token T_DOISPONTOS

%token T_LEFTBRACKET
%token T_RIGHTBRACKET
%token T_LEFTCURLY
%token T_RIGHTCURLY

%token T_COMPLEXOPERATORPLUS 
%token T_COMPLEXOPERATORMINUS

%token T_CONDITIONALIF 
%token T_CONDITIONALELSE 
%token T_LOOPWHILE 
%token T_LOOPFOR 
%token T_LOOPDO 
%token T_CONDITIONALSWITCH 
%token T_CONDITIONALCASE 
%token T_BREAK 
%token T_CONDITIONALDEFAULT

%token SYSTEM_OUT

// Tipo das expressoes
%type <sType> tipo
%type <expr_type> expressao
%type <expr_type> numeros
%type <expr_type> expressao_matematica
%type <bexpr_type> expressao_booleana
%type <stmt_type> comando
%type <stmt_type> lista_comandos
%type <stmt_type> if
%type <stmt_type> if_solo
%type <stmt_type> if_solo_linhas
%type <stmt_type> if_solo_linha
%type <stmt_type> if_else
%type <stmt_type> for
%type <stmt_type> while
%type <stmt_type> do_while
%type <stmt_type> switch
%type <stmt_type> case
%type <stmt_type> cases
%type <stmt_type> default

%type <ival> marcador
%type <ival> goto

// Procedencia
%left T_ARITH_OP T_BOOL_OP

%%

inicio: { generateHeader();	}
	lista_comandos marcador {
		remendaComLabel($2.nextList,$3);
		generateFooter();
	}
	;

lista_comandos: comando 
	| comando marcador lista_comandos {
		remendaComLabel($1.nextList,$2);
		$$.nextList = $3.nextList;
	}
	;

marcador: {
	$$ = labelsQtd;
	escreveCodigo(geraLabel() + ":");
}
;

comando: declaracao 	{vector<int> * v = new vector<int>(); $$.nextList =v;}
	| atribuicao 		{vector<int> * v = new vector<int>(); $$.nextList =v;}
    | printar 			{vector<int> * v = new vector<int>(); $$.nextList =v;}
	| if				{$$.nextList = $1.nextList;}
	| for 				{$$.nextList = $1.nextList;}
	| while 			{$$.nextList = $1.nextList;}
	| do_while 			{$$.nextList = $1.nextList;}
	| switch 			{$$.nextList = $1.nextList;}
    ;

declaracao: declaracao_normal
	| declaracao_valor
	;

declaracao_normal: tipo T_ID T_SEMICOLON {
		string str($2);
		if ($1 == INT_T) {
			defininicaoVar(str, INT_T);
		} else if ($1 == FLOAT_T) {
			defininicaoVar(str, FLOAT_T);
		}
	}
	;

declaracao_valor: tipo T_ID T_ASSING expressao T_SEMICOLON {
		string str($2);
		if ($1 == INT_T) {
			defininicaoVar(str, INT_T);
			escreveCodigo("istore " + to_string(tabelaSimbolos[str].first));
		} else if ($1 == FLOAT_T) {
			defininicaoVar(str, FLOAT_T);
			escreveCodigo("fstore " + to_string(tabelaSimbolos[str].first));
		}
	}
	;

tipo: T_TYPEINT 		{$$ = INT_T;}
	| T_TYPEDOUBLE 		{$$ = FLOAT_T;}
	| T_TYPEBOOLEAN 	{$$ = BOOL_T;}
	;

atribuicao: T_ID T_ASSING expressao T_SEMICOLON {
		string str($1);
		if (checkVar(str)) {
			if ($3.sType == tabelaSimbolos[str].second) {
				if ($3.sType == INT_T) {
					escreveCodigo("istore " + to_string(tabelaSimbolos[str].first));
				} else if ($3.sType == FLOAT_T) {
					escreveCodigo("fstore " + to_string(tabelaSimbolos[str].first));
				}
			}
		} else {
			string err = "identifier: "+str+" isn't declared in this scope";
			yyerror(err.c_str());
		}
	}
	;

expressao: numeros
	| expressao_matematica
    | T_ID {
		string str($1);
		if (checkVar(str)) {
			$$.sType = tabelaSimbolos[str].second;
			if (tabelaSimbolos[str].second == INT_T) {
				escreveCodigo("iload " + to_string(tabelaSimbolos[str].first));
			} else if (tabelaSimbolos[str].second == FLOAT_T) {
				escreveCodigo("fload " + to_string(tabelaSimbolos[str].first));
			}
		} else {
			string err = "identifier: "+str+" isn't declared in this scope";
			yyerror(err.c_str());
			$$.sType = ERROR_T;
		}
	}
	| T_LEFTBRACKET expressao T_RIGHTBRACKET {$$.sType = $2.sType;}
	;

numeros: T_REAL 	{$$.sType = FLOAT_T; escreveCodigo("ldc "+to_string($1));}
	| T_INT 		{$$.sType = INT_T;  escreveCodigo("ldc "+to_string($1));} 
	;

expressao_matematica: expressao T_ARITH_OP expressao	{operacaoMatematica($1.sType, $3.sType, string($2));}
	;

printar: SYSTEM_OUT T_LEFTBRACKET expressao T_RIGHTBRACKET T_SEMICOLON {
		if ($3.sType == INT_T) {		
			escreveCodigo("istore " + to_string(tabelaSimbolos["1syso_int_var"].first));
			escreveCodigo("getstatic      java/lang/System/out Ljava/io/PrintStream;");
			escreveCodigo("iload " + to_string(tabelaSimbolos["1syso_int_var"].first ));
			escreveCodigo("invokevirtual java/io/PrintStream/println(I)V");

		} else if ($3.sType == FLOAT_T) {
			escreveCodigo("fstore " + to_string(tabelaSimbolos["1syso_float_var"].first));
			escreveCodigo("getstatic      java/lang/System/out Ljava/io/PrintStream;");
			escreveCodigo("fload " + to_string(tabelaSimbolos["1syso_float_var"].first ));
			escreveCodigo("invokevirtual java/io/PrintStream/println(F)V");
		}
	}
	;

expressao_booleana: T_BOOL {
		if ($1) {
			$$.trueList = new vector<int> ();
			$$.trueList->push_back(listaCodigo.size());
			$$.falseList = new vector<int>();
			escreveCodigo("goto ");
		} else {
			$$.trueList = new vector<int> ();
			$$.falseList= new vector<int>();
			$$.falseList->push_back(listaCodigo.size());
			escreveCodigo("goto ");
		}
	}
	| expressao_booleana T_BOOL_OP marcador expressao_booleana {
		if (!strcmp($2, "&&")) {
			remendaComLabel($1.trueList, $3);
			$$.trueList = $4.trueList;
			$$.falseList = mergeLists($1.falseList, $4.falseList);
		}
		else if (!strcmp($2,"||")) {
			remendaComLabel($1.falseList, $3);
			$$.trueList = mergeLists($1.trueList, $4.trueList);
			$$.falseList = $4.falseList;
		}
	}	
	| expressao T_RELA_OP expressao	{
		string op ($2);
		$$.trueList = new vector<int>();
		$$.trueList ->push_back (listaCodigo.size());
		$$.falseList = new vector<int>();
		$$.falseList->push_back(listaCodigo.size()+1);
		escreveCodigo(getOperator(op)+ " ");
		escreveCodigo("goto ");
	}
	;

goto: {
	$$ = listaCodigo.size();
	escreveCodigo("goto ");
	}
	;

if: if_solo
	| if_else
	;

if_solo: if_solo_linhas
	| if_solo_linha
	;

if_solo_linhas: T_CONDITIONALIF T_LEFTBRACKET expressao_booleana T_RIGHTBRACKET T_LEFTCURLY marcador lista_comandos goto T_RIGHTCURLY marcador {
		remendaComLabel($3.trueList, $6);
		remendaComLabel($3.falseList, $10);
		$$.nextList = $7.nextList;
		$$.nextList->push_back($8);
	}
	;

if_solo_linha: T_CONDITIONALIF T_LEFTBRACKET expressao_booleana T_RIGHTBRACKET marcador comando goto marcador {
		remendaComLabel($3.trueList, $5);
		remendaComLabel($3.falseList, $8);
		$$.nextList = $6.nextList;
		$$.nextList->push_back($7);
	}
	;

if_else: T_CONDITIONALIF T_LEFTBRACKET expressao_booleana T_RIGHTBRACKET T_LEFTCURLY marcador lista_comandos goto T_RIGHTCURLY T_CONDITIONALELSE T_LEFTCURLY marcador lista_comandos T_RIGHTCURLY {
		remendaComLabel($3.trueList, $6);
		remendaComLabel($3.falseList, $12);
		$$.nextList = mergeLists($7.nextList, $13.nextList);
		$$.nextList->push_back($8);
	}
	;

for: T_LOOPFOR T_LEFTBRACKET atribuicao marcador expressao_booleana T_SEMICOLON marcador atribuicao goto T_RIGHTBRACKET T_LEFTCURLY marcador lista_comandos goto T_RIGHTCURLY {
		remendaComLabel($5.trueList, $12);
		vector<int> * v = new vector<int> ();
		v->push_back($9);
		remendaComLabel(v, $4);
		v = new vector<int>();
		v->push_back($14);
		remendaComLabel(v, $7);
		remendaComLabel($13.nextList, $7);
		$$.nextList = $5.falseList;
	}
	;

while: marcador T_LOOPWHILE T_LEFTBRACKET expressao_booleana T_RIGHTBRACKET T_LEFTCURLY marcador lista_comandos T_RIGHTCURLY {
		escreveCodigo("goto " + getLabel($1));
		remendaComLabel($8.nextList, $1);
		remendaComLabel($4.trueList, $7);
		$$.nextList = $4.falseList;
	}
	;

do_while: marcador T_LOOPDO T_LEFTCURLY lista_comandos T_RIGHTCURLY T_LOOPWHILE T_LEFTBRACKET expressao_booleana T_RIGHTBRACKET T_SEMICOLON marcador {
		escreveCodigo("goto " + getLabel($1));
		remendaComLabel($4.nextList, $1);
		remendaComLabel($8.trueList, $11);
		$$.nextList = $8.falseList;
	}
	;

switch: T_CONDITIONALSWITCH T_LEFTBRACKET expressao T_RIGHTBRACKET T_LEFTCURLY cases T_RIGHTCURLY
{
	string str("switch");
	if ($3.sType == INT_T) {
		defininicaoVar(str, INT_T);
		escreveCodigo("istore " + to_string(tabelaSimbolos[str].first));
	} else if ($3.sType == FLOAT_T) {
		defininicaoVar(str, FLOAT_T);
		escreveCodigo("fstore " + to_string(tabelaSimbolos[str].first));
	}

	$$.nextList = $6.nextList;
}
;

default: T_CONDITIONALDEFAULT T_DOISPONTOS lista_comandos
{
    $$.nextList = $3.nextList;
}
;

case: T_CONDITIONALCASE expressao T_DOISPONTOS marcador lista_comandos marcador
{
	if ($2.sType == INT_T) {	
		escreveCodigo("iload " + to_string(tabelaSimbolos["1syso_int_var"].first));
		escreveCodigo("iload " + (tabelaSimbolos.find("switch")->second).first);
		escreveCodigo("if_icmpne " + getLabel($6));
		escreveCodigo("goto " + getLabel($4));
		$$.nextList = $5.nextList;
	} else if ($2.sType == FLOAT_T) {
		escreveCodigo("fload " + to_string(tabelaSimbolos["1syso_float_var"].first));
		escreveCodigo("fload " + (tabelaSimbolos.find("switch")->second).first);
		escreveCodigo("if_icmpeq " + getLabel($4));
		escreveCodigo("goto " + getLabel($6));
		$$.nextList = $5.nextList;
	}
};

cases: case				{ $$.nextList = $1.nextList; }
	| cases case		{ $$.nextList = mergeLists($1.nextList, $2.nextList); }
	| cases default		{ $$.nextList = mergeLists($1.nextList, $2.nextList); }
;

%%

/*------------------------------separacao------------------------------------------------*/

main (int argv, char * argc[]) {
	FILE *inputFile;

	if (argv == 1) {
		inputFile = fopen("input_code.txt", "r");
		outfileName = "input_code.txt";
	} else {
		inputFile = fopen(argc[1], "r");
		outfileName = string(argc[1]);
	}

	if (!inputFile) {
		printf("Não deu para abrir o arquivo de input!\n");
		
		char cCurrentPath[200];
		if (!GetCurrentDir(cCurrentPath, sizeof(cCurrentPath))) {
		    return -1;
		}

		printf("%s\n",cCurrentPath);  
		getchar();

		return -1;
	}

	yyin = inputFile;
	yyparse();
	printCodigo();
}

void yyerror(const char * s) {
	printf("Erro na linha %d: %s\n",contLinha, s);
}

void generateHeader() {
	escreveCodigo(".source " + outfileName);
	escreveCodigo(".class public test\n.super java/lang/Object\n");
	escreveCodigo(".method public <init>()V");
	escreveCodigo("aload_0");
	escreveCodigo("invokenonvirtual java/lang/Object/<init>()V");
	escreveCodigo("return");
	escreveCodigo(".end method\n");
	escreveCodigo(".method public static main([Ljava/lang/String;)V");
	escreveCodigo(".limit locals 100\n.limit stack 100");

	// Variáveis temporárias
	defininicaoVar("1syso_int_var",INT_T);
	defininicaoVar("1syso_float_var",FLOAT_T);

	// Escreve que será a linha 1
	escreveCodigo(".line 1");
}

void generateFooter() {
	escreveCodigo("return");
	escreveCodigo(".end method");
}

bool checkVar(string op) {
	return (tabelaSimbolos.find(op) != tabelaSimbolos.end());
}

void operacaoMatematica(int from , int to, string op) {
	if (from == to) {
		if (from == INT_T) {
			escreveCodigo("i" + getOperator(op));
		} else if (from == FLOAT_T) {
			escreveCodigo("f" + getOperator(op));
		}
	} else {
		yyerror("cast not implemented yet");
	}
}

string getOperator(string op) {
	if (inst_list.find(op) != inst_list.end()) {
		return inst_list[op];
	}

	return "";
}

void defininicaoVar(string name, int type) {
	if (checkVar(name)) {
		string err = "Variável: "+name+" já foi declarada.";
		yyerror(err.c_str());
	} else {
		if (type == INT_T) {
			escreveCodigo("iconst_0\nistore " + to_string(variableQtd));
		} else if ( type == FLOAT_T) {
			escreveCodigo("fconst_0\nfstore " + to_string(variableQtd));
		}

		tabelaSimbolos[name] = make_pair(variableQtd++,(type_enum)type);
	}
}

string geraLabel() {
	return "L_"+to_string(labelsQtd++);
}

string getLabel(int n) {
	return "L_"+to_string(n);
}

void remendaComLabel(vector<int> *lists, int ind) {
	if (lists) {
		for(int i =0 ; i < lists->size() ; i++)
		{
			listaCodigo[(*lists)[i]] = listaCodigo[(*lists)[i]] + getLabel(ind);
		}	
	}
}

void escreveCodigo(string x) {
	listaCodigo.push_back(x);
}

void printCodigo(void) {
	for ( int i = 0 ; i < listaCodigo.size() ; i++) {
		fout<<listaCodigo[i]<<endl;
	}
}

vector<int> * mergeLists(vector<int> *list1, vector<int> *list2) {
	if (list1 && list2) {
		vector<int> *list = new vector<int> (*list1);
		list->insert(list->end(), list2->begin(),list2->end());
		return list;
	} else if(list1) {
		return list1;
	} else if (list2) {
		return list2;
	} else {
		return new vector<int>();
	}
}