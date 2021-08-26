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

map<string, pair<int,type_enum> > symbTab;

bool checkId(string id);
string getOp(string op);
void defineVar(string name, int type);

string genLabel();
string getLabel(int n);

void backpatch(vector<int> *list, int num);

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

%start method_body

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
%token T_ARITH_OP 
%token T_RELA_OP 
%token T_BOOL_OP 

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
%token T_QUIT

%type <sType> primitive_type
%type <expr_type> expression
%type <stmt_type> statement
%type <stmt_type> statement_list

%type <ival> marker


%%

method_body: 
	{	generateHeader();	}
	statement_list
	marker
	{
		backpatch($2.nextList,$3);
		generateFooter();
	}
	;

statement_list: 
	 statement 
	| 
	statement
	marker
	statement_list 
	{
		backpatch($1.nextList,$2);
		$$.nextList = $3.nextList;
	}
	;

marker:
{
	$$ = labelsCount;
	writeCode(genLabel() + ":");
}
;

statement: 
	declaration {vector<int> * v = new vector<int>(); $$.nextList =v;}
	| assignment {vector<int> * v = new vector<int>(); $$.nextList =v;}
    | system_print {vector<int> * v = new vector<int>(); $$.nextList =v;}
    ;

declaration: 
	primitive_type T_ID T_SEMICOLON
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

primitive_type: 
	T_TYPEINT {$$ = INT_T;}
	| T_TYPEDOUBLE {$$ = FLOAT_T;}
	;

assignment: 
	T_ID T_ASSING expression T_SEMICOLON
	{
		string str($1);
		/* after expression finishes, its result should be on top of stack. 
		we just store the top of stack to the identifier*/
		if(checkId(str))
		{
			if($3.sType == symbTab[str].second)
			{
				if($3.sType == INT_T)
				{
					writeCode("istore " + to_string(symbTab[str].first));
				}else if ($3.sType == FLOAT_T)
				{
					writeCode("fstore " + to_string(symbTab[str].first));
				}
			}
		}else{
			string err = "identifier: "+str+" isn't declared in this scope";
			yyerror(err.c_str());
		}
	}
	;

expression: 
	T_REAL 	{$$.sType = FLOAT_T; writeCode("ldc "+to_string($1));}
	| T_INT 	{$$.sType = INT_T;  writeCode("ldc "+to_string($1));} 
    | T_ID {
		string str($1);
		if(checkId(str))
		{
			$$.sType = symbTab[str].second;
			if(symbTab[str].second == INT_T)
			{
				writeCode("iload " + to_string(symbTab[str].first));
			}else if (symbTab[str].second == FLOAT_T)
			{
				writeCode("fload " + to_string(symbTab[str].first));
			}
		}
		else
		{
			string err = "identifier: "+str+" isn't declared in this scope";
			yyerror(err.c_str());
			$$.sType = ERROR_T;
		}
	}
	| T_LEFTBRACKET expression T_RIGHTBRACKET {$$.sType = $2.sType;}
	;
    ;

system_print:
	SYSTEM_OUT T_LEFTBRACKET expression T_RIGHTBRACKET T_SEMICOLON
	{
		if($3.sType == INT_T)
		{		
			writeCode("istore " + to_string(symbTab["1syso_int_var"].first));
			writeCode("getstatic      java/lang/System/out Ljava/io/PrintStream;");
			writeCode("iload " + to_string(symbTab["1syso_int_var"].first ));
			writeCode("invokevirtual java/io/PrintStream/println(I)V");

		}else if ($3.sType == FLOAT_T)
		{
			writeCode("fstore " + to_string(symbTab["1syso_float_var"].first));
			writeCode("getstatic      java/lang/System/out Ljava/io/PrintStream;");
			writeCode("fload " + to_string(symbTab["1syso_float_var"].first ));
			writeCode("invokevirtual java/io/PrintStream/println(F)V");
		}
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
	return (symbTab.find(op) != symbTab.end());
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
		symbTab[name] = make_pair(varaiblesNum++,(type_enum)type);
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
