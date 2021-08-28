%{
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

extern  int yylex();
//extern  int yyparse();
extern  FILE *yyin;
void yyerror(const char * s);
extern int lineCounter;

#define TRUE 1
#define FALSE 0
string outfileName ;

ofstream fout("output.j");	/* file for writing output */
void generateHeader(void);	/* generate  header for class to be able to compile the code*/
void generateFooter(void);	/* generate  footer for class to be able to compile the code*/

int varaiblesNum = 1; 	/* new variable will be issued this number, java starts with 1, 0 is 'this' */
int labelsCount = 0;	/* to generate labels */

typedef enum {INT_T, FLOAT_T, BOOL_T, VOID_T, ERROR_T} type_enum;

map<string, pair<int,type_enum> > tabelaSimbolos;

bool checkId(string id);
string getOp(string op);
void defineVar(string name, int type);

void arithCast(int from , int to, string op);

string genLabel();
string getLabel(int n);

void backpatch(vector<int> *list, int num);

vector<int> * merge (vector<int> *list1, vector<int>* list2);
vector<string> codeList;
void writeCode(string x);

void printCode(void);
void printLineNumber(int num)
{
	writeCode(".line "+ to_string(num));
}

%}

%code requires {
	#include <vector>
	using namespace std;
}

%start inicio

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

%token <ival> T_INT
%token <fval> T_REAL
%token <idval> T_ID
%token <bval> T_BOOL
%token <aopval> T_ARITH_OP
%token <aopval> T_RELA_OP
%token <aopval> T_BOOL_OP

%token T_TYPEINT
%token T_TYPEDOUBLE
%token T_TYPEBOOLEAN
%token T_CONST

%token T_SEMICOLON
%token T_ASSING

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

%type <ival> marcador
%type <ival> goto


%left T_ARITH_OP T_BOOL_OP

%%

inicio: 
	{	generateHeader();	}
	lista_comandos
	marcador
	{
		backpatch($2.nextList,$3);
		generateFooter();
	}
	;

lista_comandos: 
	 comando 
	| 
	comando
	marcador
	lista_comandos 
	{
		backpatch($1.nextList,$2);
		$$.nextList = $3.nextList;
	}
	;

marcador:
{
	$$ = labelsCount;
	writeCode(genLabel() + ":");
}
;

comando: 
	  declaracao 	{vector<int> * v = new vector<int>(); $$.nextList =v;}
	| atribuicao 	{vector<int> * v = new vector<int>(); $$.nextList =v;}
    | printar 		{vector<int> * v = new vector<int>(); $$.nextList =v;}
	| if			{$$.nextList = $1.nextList;}
	| for 			{$$.nextList = $1.nextList;}
	// acrescentar o switch
	// acrescentar o while
	// acrescentar o do while
    ;

declaracao: 
	declaracao_normal
	| declaracao_valor
	;

declaracao_normal: 
	tipo T_ID T_SEMICOLON
	{
		string str($2);
		if($1 == INT_T)
		{
			defineVar(str,INT_T);
		}else if ($1 == FLOAT_T)
		{
			defineVar(str,FLOAT_T);
		}
	}
	;

declaracao_valor: 
	tipo T_ID T_ASSING expressao T_SEMICOLON
	{
		string str($2);
		if($1 == INT_T)
		{
			defineVar(str,INT_T);
		}else if ($1 == FLOAT_T)
		{
			defineVar(str,FLOAT_T);
		}

		if(checkId(str))
		{
			if($4.sType == tabelaSimbolos[str].second)
			{
				if($4.sType == INT_T)
				{
					writeCode("istore " + to_string(tabelaSimbolos[str].first));
				}else if ($4.sType == FLOAT_T)
				{
					writeCode("fstore " + to_string(tabelaSimbolos[str].first));
				}
			}
		}else{
			string err = "identifier: "+str+" isn't declared in this scope";
			yyerror(err.c_str());
		}
	}
	;

tipo: 
	  T_TYPEINT 		{$$ = INT_T;}
	| T_TYPEDOUBLE 		{$$ = FLOAT_T;}
	| T_TYPEBOOLEAN 	{$$ = BOOL_T;}
	;

atribuicao: 
	T_ID T_ASSING expressao T_SEMICOLON
	{
		string str($1);
		if(checkId(str))
		{
			if($3.sType == tabelaSimbolos[str].second)
			{
				if($3.sType == INT_T)
				{
					writeCode("istore " + to_string(tabelaSimbolos[str].first));
				}else if ($3.sType == FLOAT_T)
				{
					writeCode("fstore " + to_string(tabelaSimbolos[str].first));
				}
			}
		}else{
			string err = "identifier: "+str+" isn't declared in this scope";
			yyerror(err.c_str());
		}
	}
	;

expressao: 
	  numeros
	| expressao_matematica
    | T_ID {
		string str($1);
		if(checkId(str))
		{
			$$.sType = tabelaSimbolos[str].second;
			if(tabelaSimbolos[str].second == INT_T)
			{
				writeCode("iload " + to_string(tabelaSimbolos[str].first));
			}else if (tabelaSimbolos[str].second == FLOAT_T)
			{
				writeCode("fload " + to_string(tabelaSimbolos[str].first));
			}
		}
		else
		{
			string err = "identifier: "+str+" isn't declared in this scope";
			yyerror(err.c_str());
			$$.sType = ERROR_T;
		}
	}
	| T_LEFTBRACKET expressao T_RIGHTBRACKET {$$.sType = $2.sType;}
	;

numeros:
	T_REAL 	{$$.sType = FLOAT_T; writeCode("ldc "+to_string($1));}
	| T_INT 	{$$.sType = INT_T;  writeCode("ldc "+to_string($1));} 
	;

expressao_matematica:
	expressao T_ARITH_OP expressao	{arithCast($1.sType, $3.sType, string($2));}
	;


printar:
	SYSTEM_OUT T_LEFTBRACKET expressao T_RIGHTBRACKET T_SEMICOLON
	{
		if($3.sType == INT_T)
		{		
			writeCode("istore " + to_string(tabelaSimbolos["1syso_int_var"].first));
			writeCode("getstatic      java/lang/System/out Ljava/io/PrintStream;");
			writeCode("iload " + to_string(tabelaSimbolos["1syso_int_var"].first ));
			writeCode("invokevirtual java/io/PrintStream/println(I)V");

		}else if ($3.sType == FLOAT_T)
		{
			writeCode("fstore " + to_string(tabelaSimbolos["1syso_float_var"].first));
			writeCode("getstatic      java/lang/System/out Ljava/io/PrintStream;");
			writeCode("fload " + to_string(tabelaSimbolos["1syso_float_var"].first ));
			writeCode("invokevirtual java/io/PrintStream/println(F)V");
		}
	}
	;

expressao_booleana:
	T_BOOL
	{
		if($1)
		{
			/* bool is 'true' */
			$$.trueList = new vector<int> ();
			$$.trueList->push_back(codeList.size());
			$$.falseList = new vector<int>();
			writeCode("goto ");
		}else
		{
			$$.trueList = new vector<int> ();
			$$.falseList= new vector<int>();
			$$.falseList->push_back(codeList.size());
			writeCode("goto ");
		}
	}
	|expressao_booleana
	T_BOOL_OP 
	marcador
	expressao_booleana
	{
		if(!strcmp($2, "&&"))
		{
			backpatch($1.trueList, $3);
			$$.trueList = $4.trueList;
			$$.falseList = merge($1.falseList,$4.falseList);
		}
		else if (!strcmp($2,"||"))
		{
			backpatch($1.falseList,$3);
			$$.trueList = merge($1.trueList, $4.trueList);
			$$.falseList = $4.falseList;
		}
	}	
	| expressao T_RELA_OP expressao		
	{
		string op ($2);
		$$.trueList = new vector<int>();
		$$.trueList ->push_back (codeList.size());
		$$.falseList = new vector<int>();
		$$.falseList->push_back(codeList.size()+1);
		writeCode(getOp(op)+ " ");
		writeCode("goto ");
	}
	/*|expression T_RELA_OP T_BOOL 	// to be considered */ 
	;

goto:
{
	$$ = codeList.size();
	writeCode("goto ");
}
;

if:
	if_solo
	|
	if_else
	;

if_solo: 
	 if_solo_linhas
	|
	 if_solo_linha
	;

if_solo_linhas: 
	T_CONDITIONALIF T_LEFTBRACKET 
	expressao_booleana 
	T_RIGHTBRACKET T_LEFTCURLY 
	marcador
	lista_comandos
	goto 
	T_RIGHTCURLY
	marcador
	{
		backpatch($3.trueList,$6);
		backpatch($3.falseList,$10);
		$$.nextList = $7.nextList;
		$$.nextList->push_back($8);
	}
	;

if_solo_linha: 
	T_CONDITIONALIF T_LEFTBRACKET 
	expressao_booleana 
	T_RIGHTBRACKET 
	marcador
	comando
	goto 
	marcador
	{
		backpatch($3.trueList,$5);
		backpatch($3.falseList,$8);
		$$.nextList = $6.nextList;
		$$.nextList->push_back($7);
	}
	;

if_else: 
	T_CONDITIONALIF T_LEFTBRACKET 
	expressao_booleana 
	T_RIGHTBRACKET T_LEFTCURLY 
	marcador
	lista_comandos
	goto 
	T_RIGHTCURLY 
	T_CONDITIONALELSE T_LEFTCURLY 
	marcador
	lista_comandos 
	T_RIGHTCURLY
	{
		backpatch($3.trueList,$6);
		backpatch($3.falseList,$12);
		$$.nextList = merge($7.nextList, $13.nextList);
		$$.nextList->push_back($8);
	}
	;

switch: T_CONDITIONALSWITCH T_LEFTBRACKET expressao T_RIGHTBRACKET T_LEFTCURLY marcador cases goto T_RIGHTCURLY
	{
		// primeiro verifica se expressao já é uma váriavel, se for, não precisa fazer isso
		string str("switch");
		if($3 == INT_T)
		{
			defineVar(str,INT_T);
		}else if ($3 == FLOAT_T)
		{
			defineVar(str,FLOAT_T);
		}
	}
	;

case: T_CONDITIONALCASE expressao ':' T_LEFTCURLY marcador lista_comandos goto T_RIGHTCURLY {
	backpatch($3.trueList,$5);
	backpatch($3.falseList,$8);
	$$.nextList = $6.nextList;
	$$.nextList->push_back($7);
}

default: T_CONDITIONALDEFAULT ':' T_LEFTCURLY lista_comandos T_RIGHTCURLY {

}

cases: case 
	| default 
	| case cases

for:
	T_LOOPFOR 
	T_LEFTBRACKET
	atribuicao
	marcador
	expressao_booleana
	T_SEMICOLON
	marcador
	atribuicao
	goto
	T_RIGHTBRACKET
	T_LEFTCURLY
	marcador
	lista_comandos
	goto
	T_RIGHTCURLY
	{
		backpatch($5.trueList,$12);
		vector<int> * v = new vector<int> ();
		v->push_back($9);
		backpatch(v,$4);
		v = new vector<int>();
		v->push_back($14);
		backpatch(v,$7);
		backpatch($13.nextList,$7);
		$$.nextList = $5.falseList;
	}
	;

%%

/*------------------------------separator------------------------------------------------*/

main (int argv, char * argc[])
{
	FILE *myfile;
	if(argv == 1) 
	{
		myfile = fopen("input_code.txt", "r");
		outfileName = "input_code.txt";
	}
	else 
	{
		myfile = fopen(argc[1], "r");
		outfileName = string(argc[1]);
	}
	if (!myfile) {
		printf("I can't open input code file!\n");
		char cCurrentPath[200];
		 if (!GetCurrentDir(cCurrentPath, sizeof(cCurrentPath)))
		     {
		     return -1;
		     }
		printf("%s\n",cCurrentPath);  
				getchar();

		return -1;

	}
	yyin = myfile;
	yyparse();
	//getchar();
	printCode();
}

void yyerror(const char * s)
{
	printf("error@%d: %s\n",lineCounter, s);
}

void generateHeader()
{
	writeCode(".source " + outfileName);
	writeCode(".class public test\n.super java/lang/Object\n"); //code for defining class
	writeCode(".method public <init>()V");
	writeCode("aload_0");
	writeCode("invokenonvirtual java/lang/Object/<init>()V");
	writeCode("return");
	writeCode(".end method\n");
	writeCode(".method public static main([Ljava/lang/String;)V");
	writeCode(".limit locals 100\n.limit stack 100");

	/* generate temporal vars for syso*/
	defineVar("1syso_int_var",INT_T);
	defineVar("1syso_float_var",FLOAT_T);

	/*generate line*/
	writeCode(".line 1");
}

void generateFooter()
{
	writeCode("return");
	writeCode(".end method");
}

bool checkId(string op)
{
	return (tabelaSimbolos.find(op) != tabelaSimbolos.end());
}

void arithCast(int from , int to, string op)
{
	if(from == to)
	{
		if(from == INT_T)
		{
			writeCode("i" + getOp(op));
		}else if (from == FLOAT_T)
		{
			writeCode("f" + getOp(op));
		}
	}
	else
	{
		yyerror("cast not implemented yet");
	}
}

string getOp(string op)
{
	if(inst_list.find(op) != inst_list.end())
	{
		return inst_list[op];
	}
	return "";
}

void defineVar(string name, int type)
{
	if(checkId(name))
	{
		string err = "variable: "+name+" declared before";
		yyerror(err.c_str());
	}else
	{
		if(type == INT_T)
		{
			writeCode("iconst_0\nistore " + to_string(varaiblesNum));
		}
		else if ( type == FLOAT_T)
		{
			writeCode("fconst_0\nfstore " + to_string(varaiblesNum));
		}
		tabelaSimbolos[name] = make_pair(varaiblesNum++,(type_enum)type);
	}
}

string genLabel()
{
	return "L_"+to_string(labelsCount++);
}

string getLabel(int n)
{
	return "L_"+to_string(n);
}

void backpatch(vector<int> *lists, int ind)
{
	if(lists)
	for(int i =0 ; i < lists->size() ; i++)
	{
		codeList[(*lists)[i]] = codeList[(*lists)[i]] + getLabel(ind);
	}
}
void writeCode(string x)
{
	codeList.push_back(x);
}

void printCode(void)
{
	for ( int i = 0 ; i < codeList.size() ; i++)
	{
		fout<<codeList[i]<<endl;
	}
}

vector<int> * merge(vector<int> *list1, vector<int> *list2)
{
	if(list1 && list2){
		vector<int> *list = new vector<int> (*list1);
		list->insert(list->end(), list2->begin(),list2->end());
		return list;
	}else if(list1)
	{
		return list1;
	}else if (list2)
	{
		return list2;
	}else
	{
		return new vector<int>();
	}
}