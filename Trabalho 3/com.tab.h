/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_COM_TAB_H_INCLUDED
# define YY_YY_COM_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif
/* "%code requires" blocks.  */
#line 61 "com.y" /* yacc.c:1909  */

	#include <vector>
	using namespace std;

#line 49 "com.tab.h" /* yacc.c:1909  */

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    T_INT = 258,
    T_REAL = 259,
    T_ID = 260,
    T_BOOL = 261,
    T_ARITH_OP = 262,
    T_RELA_OP = 263,
    T_BOOL_OP = 264,
    T_TYPEINT = 265,
    T_TYPEDOUBLE = 266,
    T_TYPEBOOLEAN = 267,
    T_CONST = 268,
    T_SEMICOLON = 269,
    T_ASSING = 270,
    T_LEFTBRACKET = 271,
    T_RIGHTBRACKET = 272,
    T_LEFTCURLY = 273,
    T_RIGHTCURLY = 274,
    T_COMPLEXOPERATORPLUS = 275,
    T_COMPLEXOPERATORMINUS = 276,
    T_CONDITIONALIF = 277,
    T_CONDITIONALELSE = 278,
    T_LOOPWHILE = 279,
    T_LOOPFOR = 280,
    T_LOOPDO = 281,
    T_CONDITIONALSWITCH = 282,
    T_CONDITIONALCASE = 283,
    T_BREAK = 284,
    T_CONDITIONALDEFAULT = 285,
    SYSTEM_OUT = 286
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 68 "com.y" /* yacc.c:1909  */

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

#line 111 "com.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_COM_TAB_H_INCLUDED  */
