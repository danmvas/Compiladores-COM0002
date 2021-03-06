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

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    T_INT = 258,
    T_REAL = 259,
    T_QUIT = 260,
    T_OPERATOR = 261,
    T_LEFT = 262,
    T_RIGHT = 263,
    T_ID = 264,
    T_ASSING = 265,
    T_COMPLEXOPERATORPLUS = 266,
    T_COMPLEXOPERATORMINUS = 267,
    T_CONDITIONALIF = 268,
    T_RIGHTCURLY = 269,
    T_LEFTCURLY = 270,
    T_CONDITIONALELSE = 271,
    T_CONDITIONALSWITCH = 272,
    T_CONDITIONALCASE = 273,
    T_TWODOTS = 274,
    T_CONDITIONALDEFAULT = 275,
    T_LOOPFOR = 276,
    T_LOOPWHILE = 277,
    T_LOOPDO = 278,
    T_BREAK = 279,
    T_EQUAL = 280,
    T_SEMMICOLON = 281,
    T_LOOPCONTINUE = 282,
    T_TYPEDOUBLE = 283,
    T_TYPEINT = 284,
    T_RETURN = 285,
    T_CONST = 286,
    T_GREATER = 287,
    T_GREATEREQUAL = 288,
    T_MINOREQUAL = 289,
    T_MINOR = 290,
    T_NOTEQUAL = 291
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 18 "com.y" /* yacc.c:1909  */

	int ival;
	float fval;
	bool bval;

#line 97 "com.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_COM_TAB_H_INCLUDED  */
