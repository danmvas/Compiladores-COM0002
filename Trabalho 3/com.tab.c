/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.4"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 1 "com.y" /* yacc.c:339  */

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


#line 126 "com.tab.c" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "com.tab.h".  */
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
#line 61 "com.y" /* yacc.c:355  */

	#include <vector>
	using namespace std;

#line 161 "com.tab.c" /* yacc.c:355  */

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
#line 68 "com.y" /* yacc.c:355  */

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

#line 223 "com.tab.c" /* yacc.c:355  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_COM_TAB_H_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 240 "com.tab.c" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  3
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   105

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  32
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  26
/* YYNRULES -- Number of rules.  */
#define YYNRULES  45
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  114

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   286

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   148,   148,   148,   158,   160,   170,   177,   178,   179,
     180,   181,   182,   183,   184,   189,   190,   194,   208,   239,
     240,   241,   245,   268,   269,   270,   290,   294,   295,   299,
     303,   308,   328,   344,   359,   372,   379,   381,   385,   387,
     391,   408,   424,   444,   473,   489
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "T_INT", "T_REAL", "T_ID", "T_BOOL",
  "T_ARITH_OP", "T_RELA_OP", "T_BOOL_OP", "T_TYPEINT", "T_TYPEDOUBLE",
  "T_TYPEBOOLEAN", "T_CONST", "T_SEMICOLON", "T_ASSING", "T_LEFTBRACKET",
  "T_RIGHTBRACKET", "T_LEFTCURLY", "T_RIGHTCURLY", "T_COMPLEXOPERATORPLUS",
  "T_COMPLEXOPERATORMINUS", "T_CONDITIONALIF", "T_CONDITIONALELSE",
  "T_LOOPWHILE", "T_LOOPFOR", "T_LOOPDO", "T_CONDITIONALSWITCH",
  "T_CONDITIONALCASE", "T_BREAK", "T_CONDITIONALDEFAULT", "SYSTEM_OUT",
  "$accept", "inicio", "$@1", "lista_comandos", "marcador", "comando",
  "declaracao", "declaracao_normal", "declaracao_valor", "tipo",
  "atribuicao", "expressao", "numeros", "expressao_matematica",
  "expressao_matematica_unitaria", "printar", "expressao_booleana", "goto",
  "if", "if_solo", "if_solo_linhas", "if_solo_linha", "if_else", "for",
  "while", "do_while", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286
};
# endif

#define YYPACT_NINF -80

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-80)))

#define YYTABLE_NINF -5

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int8 yypact[] =
{
     -80,    15,    55,   -80,    35,   -80,   -80,   -80,     4,    14,
      25,   -80,    44,     3,   -80,   -80,   -80,    27,   -80,   -80,
     -80,   -80,   -80,   -80,   -80,   -80,   -80,   -80,   -80,    42,
      39,    23,    58,    42,   -80,    33,    51,    55,    -3,   -80,
     -80,   -80,    42,    30,   -80,   -80,   -80,   -80,    71,     0,
      56,   -80,     1,    23,    55,   -80,   -80,    42,     6,    42,
     -80,    42,   -80,    63,    23,    68,    16,    64,    47,   -80,
     -80,    77,    23,   -80,    55,    50,   -80,    69,    65,   -80,
     -80,    55,   -80,   -80,   -80,    72,   -80,   -80,    58,    55,
      23,    76,   -80,   -80,    78,    26,    67,    74,   -80,    82,
      80,   -80,    81,   -80,   -80,   -80,   -80,    55,    55,    83,
     -80,   -80,    84,   -80
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       2,     0,     6,     1,     0,    19,    20,    21,     0,     0,
       0,     6,     0,     6,     7,    15,    16,     0,     8,    14,
       9,    10,    36,    38,    39,    37,    11,    12,    13,     0,
       0,     0,     0,     0,     3,     0,     0,     6,     0,    28,
      27,    25,     0,     0,    23,    24,    30,    32,     0,     0,
       0,     6,     0,     0,     6,     5,    17,     0,     0,     0,
      22,     0,     6,     6,     0,     0,     0,     0,     0,    26,
      29,    34,     0,     6,     6,     0,    31,     0,     0,    18,
      33,     6,    35,     6,     6,     0,    35,     6,     0,     6,
       0,     0,    41,    35,     0,     0,     6,     0,    44,     0,
       0,    40,     0,     6,     6,     6,    45,     6,     6,     0,
      35,    42,     0,    43
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -80,   -80,   -80,   -33,   -11,    31,   -80,   -80,   -80,   -80,
     -31,   -23,   -80,   -80,   -80,   -80,   -48,   -79,   -80,   -80,
     -80,   -80,   -80,   -80,   -80,   -80
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     1,     2,    11,    12,    13,    14,    15,    16,    17,
      18,    48,    44,    45,    19,    20,    49,    87,    21,    22,
      23,    24,    25,    26,    27,    28
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int8 yytable[] =
{
      34,    51,    37,    -4,    55,    66,    43,    91,    59,    62,
      52,    56,    57,    59,    97,     3,    75,    63,    65,    58,
      31,    67,    -4,    69,    80,    62,    39,    40,    41,    47,
      32,   112,    38,    77,    68,    62,    70,    59,    71,    42,
      64,    33,    95,    99,    60,    39,    40,    41,    86,    53,
      29,    72,    74,    46,    59,    30,    94,    93,    42,    62,
       4,    79,    81,    50,    83,     5,     6,     7,    35,    54,
      36,    29,    88,    89,   109,   110,    92,     8,    59,    61,
       9,    73,    76,    78,    59,   101,    10,    84,    90,    85,
     100,   102,   106,   107,   108,    96,   103,    98,   104,   105,
       0,     0,   111,   113,     0,    82
};

static const yytype_int8 yycheck[] =
{
      11,    32,    13,     0,    37,    53,    29,    86,     7,     9,
      33,    14,    15,     7,    93,     0,    64,    17,    17,    42,
      16,    54,    19,    17,    72,     9,     3,     4,     5,     6,
      16,   110,     5,    17,    57,     9,    59,     7,    61,    16,
      51,    16,    90,    17,    14,     3,     4,     5,    81,    16,
      15,    62,    63,    14,     7,    20,    89,    88,    16,     9,
       5,    14,    73,     5,    14,    10,    11,    12,    24,    18,
      26,    15,    83,    84,   107,   108,    87,    22,     7,     8,
      25,    18,    14,    19,     7,    96,    31,    18,    16,    24,
      23,    17,   103,   104,   105,    19,    14,    19,    18,    18,
      -1,    -1,    19,    19,    -1,    74
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    33,    34,     0,     5,    10,    11,    12,    22,    25,
      31,    35,    36,    37,    38,    39,    40,    41,    42,    46,
      47,    50,    51,    52,    53,    54,    55,    56,    57,    15,
      20,    16,    16,    16,    36,    24,    26,    36,     5,     3,
       4,     5,    16,    43,    44,    45,    14,     6,    43,    48,
       5,    42,    43,    16,    18,    35,    14,    15,    43,     7,
      14,     8,     9,    17,    36,    17,    48,    35,    43,    17,
      43,    43,    36,    18,    36,    48,    14,    17,    19,    14,
      48,    36,    37,    14,    18,    24,    35,    49,    36,    36,
      16,    49,    36,    42,    35,    48,    19,    49,    19,    17,
      23,    36,    17,    14,    18,    18,    36,    36,    36,    35,
      35,    19,    49,    19
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    32,    34,    33,    35,    35,    36,    37,    37,    37,
      37,    37,    37,    37,    37,    38,    38,    39,    40,    41,
      41,    41,    42,    43,    43,    43,    43,    44,    44,    45,
      46,    47,    48,    48,    48,    49,    50,    50,    51,    51,
      52,    53,    54,    55,    56,    57
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     0,     3,     1,     3,     0,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     3,     5,     1,
       1,     1,     4,     1,     1,     1,     3,     1,     1,     3,
       3,     5,     1,     4,     3,     0,     1,     1,     1,     1,
      10,     8,    14,    15,     9,    11
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);

        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 148 "com.y" /* yacc.c:1646  */
    {	generateHeader();	}
#line 1391 "com.tab.c" /* yacc.c:1646  */
    break;

  case 3:
#line 151 "com.y" /* yacc.c:1646  */
    {
		backpatch((yyvsp[-1].stmt_type).nextList,(yyvsp[0].ival));
		generateFooter();
	}
#line 1400 "com.tab.c" /* yacc.c:1646  */
    break;

  case 5:
#line 163 "com.y" /* yacc.c:1646  */
    {
		backpatch((yyvsp[-2].stmt_type).nextList,(yyvsp[-1].ival));
		(yyval.stmt_type).nextList = (yyvsp[0].stmt_type).nextList;
	}
#line 1409 "com.tab.c" /* yacc.c:1646  */
    break;

  case 6:
#line 170 "com.y" /* yacc.c:1646  */
    {
	(yyval.ival) = labelsCount;
	writeCode(genLabel() + ":");
}
#line 1418 "com.tab.c" /* yacc.c:1646  */
    break;

  case 7:
#line 177 "com.y" /* yacc.c:1646  */
    {vector<int> * v = new vector<int>(); (yyval.stmt_type).nextList =v;}
#line 1424 "com.tab.c" /* yacc.c:1646  */
    break;

  case 8:
#line 178 "com.y" /* yacc.c:1646  */
    {vector<int> * v = new vector<int>(); (yyval.stmt_type).nextList =v;}
#line 1430 "com.tab.c" /* yacc.c:1646  */
    break;

  case 9:
#line 179 "com.y" /* yacc.c:1646  */
    {vector<int> * v = new vector<int>(); (yyval.stmt_type).nextList =v;}
#line 1436 "com.tab.c" /* yacc.c:1646  */
    break;

  case 10:
#line 180 "com.y" /* yacc.c:1646  */
    {(yyval.stmt_type).nextList = (yyvsp[0].stmt_type).nextList;}
#line 1442 "com.tab.c" /* yacc.c:1646  */
    break;

  case 11:
#line 181 "com.y" /* yacc.c:1646  */
    {(yyval.stmt_type).nextList = (yyvsp[0].stmt_type).nextList;}
#line 1448 "com.tab.c" /* yacc.c:1646  */
    break;

  case 12:
#line 182 "com.y" /* yacc.c:1646  */
    {(yyval.stmt_type).nextList = (yyvsp[0].stmt_type).nextList;}
#line 1454 "com.tab.c" /* yacc.c:1646  */
    break;

  case 13:
#line 183 "com.y" /* yacc.c:1646  */
    {(yyval.stmt_type).nextList = (yyvsp[0].stmt_type).nextList;}
#line 1460 "com.tab.c" /* yacc.c:1646  */
    break;

  case 14:
#line 184 "com.y" /* yacc.c:1646  */
    {printf("ué"); }
#line 1466 "com.tab.c" /* yacc.c:1646  */
    break;

  case 17:
#line 195 "com.y" /* yacc.c:1646  */
    {
		string str((yyvsp[-1].idval));
		if((yyvsp[-2].sType) == INT_T)
		{
			defineVar(str,INT_T);
		}else if ((yyvsp[-2].sType) == FLOAT_T)
		{
			defineVar(str,FLOAT_T);
		}
	}
#line 1481 "com.tab.c" /* yacc.c:1646  */
    break;

  case 18:
#line 209 "com.y" /* yacc.c:1646  */
    {
		string str((yyvsp[-3].idval));
		if((yyvsp[-4].sType) == INT_T)
		{
			defineVar(str,INT_T);
		}else if ((yyvsp[-4].sType) == FLOAT_T)
		{
			defineVar(str,FLOAT_T);
		}

		if(checkId(str))
		{
			if((yyvsp[-1].expr_type).sType == tabelaSimbolos[str].second)
			{
				if((yyvsp[-1].expr_type).sType == INT_T)
				{
					writeCode("istore " + to_string(tabelaSimbolos[str].first));
				}else if ((yyvsp[-1].expr_type).sType == FLOAT_T)
				{
					writeCode("fstore " + to_string(tabelaSimbolos[str].first));
				}
			}
		}else{
			string err = "identifier: "+str+" isn't declared in this scope";
			yyerror(err.c_str());
		}
	}
#line 1513 "com.tab.c" /* yacc.c:1646  */
    break;

  case 19:
#line 239 "com.y" /* yacc.c:1646  */
    {(yyval.sType) = INT_T;}
#line 1519 "com.tab.c" /* yacc.c:1646  */
    break;

  case 20:
#line 240 "com.y" /* yacc.c:1646  */
    {(yyval.sType) = FLOAT_T;}
#line 1525 "com.tab.c" /* yacc.c:1646  */
    break;

  case 21:
#line 241 "com.y" /* yacc.c:1646  */
    {(yyval.sType) = BOOL_T;}
#line 1531 "com.tab.c" /* yacc.c:1646  */
    break;

  case 22:
#line 246 "com.y" /* yacc.c:1646  */
    {
		string str((yyvsp[-3].idval));
		if(checkId(str))
		{
			if((yyvsp[-1].expr_type).sType == tabelaSimbolos[str].second)
			{
				if((yyvsp[-1].expr_type).sType == INT_T)
				{
					writeCode("istore " + to_string(tabelaSimbolos[str].first));
				}else if ((yyvsp[-1].expr_type).sType == FLOAT_T)
				{
					writeCode("fstore " + to_string(tabelaSimbolos[str].first));
				}
			}
		}else{
			string err = "identifier: "+str+" isn't declared in this scope";
			yyerror(err.c_str());
		}
	}
#line 1555 "com.tab.c" /* yacc.c:1646  */
    break;

  case 25:
#line 270 "com.y" /* yacc.c:1646  */
    {
		string str((yyvsp[0].idval));
		if(checkId(str))
		{
			(yyval.expr_type).sType = tabelaSimbolos[str].second;
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
			(yyval.expr_type).sType = ERROR_T;
		}
	}
#line 1580 "com.tab.c" /* yacc.c:1646  */
    break;

  case 26:
#line 290 "com.y" /* yacc.c:1646  */
    {(yyval.expr_type).sType = (yyvsp[-1].expr_type).sType;}
#line 1586 "com.tab.c" /* yacc.c:1646  */
    break;

  case 27:
#line 294 "com.y" /* yacc.c:1646  */
    {(yyval.expr_type).sType = FLOAT_T; writeCode("ldc "+to_string((yyvsp[0].fval)));}
#line 1592 "com.tab.c" /* yacc.c:1646  */
    break;

  case 28:
#line 295 "com.y" /* yacc.c:1646  */
    {(yyval.expr_type).sType = INT_T;  writeCode("ldc "+to_string((yyvsp[0].ival)));}
#line 1598 "com.tab.c" /* yacc.c:1646  */
    break;

  case 29:
#line 299 "com.y" /* yacc.c:1646  */
    {arithCast((yyvsp[-2].expr_type).sType, (yyvsp[0].expr_type).sType, string((yyvsp[-1].aopval)));}
#line 1604 "com.tab.c" /* yacc.c:1646  */
    break;

  case 30:
#line 303 "com.y" /* yacc.c:1646  */
    { printf("opa"); }
#line 1610 "com.tab.c" /* yacc.c:1646  */
    break;

  case 31:
#line 309 "com.y" /* yacc.c:1646  */
    {
		if((yyvsp[-2].expr_type).sType == INT_T)
		{		
			writeCode("istore " + to_string(tabelaSimbolos["1syso_int_var"].first));
			writeCode("getstatic      java/lang/System/out Ljava/io/PrintStream;");
			writeCode("iload " + to_string(tabelaSimbolos["1syso_int_var"].first ));
			writeCode("invokevirtual java/io/PrintStream/println(I)V");

		}else if ((yyvsp[-2].expr_type).sType == FLOAT_T)
		{
			writeCode("fstore " + to_string(tabelaSimbolos["1syso_float_var"].first));
			writeCode("getstatic      java/lang/System/out Ljava/io/PrintStream;");
			writeCode("fload " + to_string(tabelaSimbolos["1syso_float_var"].first ));
			writeCode("invokevirtual java/io/PrintStream/println(F)V");
		}
	}
#line 1631 "com.tab.c" /* yacc.c:1646  */
    break;

  case 32:
#line 329 "com.y" /* yacc.c:1646  */
    {
		if((yyvsp[0].bval))
		{
			(yyval.bexpr_type).trueList = new vector<int> ();
			(yyval.bexpr_type).trueList->push_back(codeList.size());
			(yyval.bexpr_type).falseList = new vector<int>();
			writeCode("goto ");
		}else
		{
			(yyval.bexpr_type).trueList = new vector<int> ();
			(yyval.bexpr_type).falseList= new vector<int>();
			(yyval.bexpr_type).falseList->push_back(codeList.size());
			writeCode("goto ");
		}
	}
#line 1651 "com.tab.c" /* yacc.c:1646  */
    break;

  case 33:
#line 345 "com.y" /* yacc.c:1646  */
    {
		if(!strcmp((yyvsp[-2].aopval), "&&"))
		{
			backpatch((yyvsp[-3].bexpr_type).trueList, (yyvsp[-1].ival));
			(yyval.bexpr_type).trueList = (yyvsp[0].bexpr_type).trueList;
			(yyval.bexpr_type).falseList = merge((yyvsp[-3].bexpr_type).falseList,(yyvsp[0].bexpr_type).falseList);
		}
		else if (!strcmp((yyvsp[-2].aopval),"||"))
		{
			backpatch((yyvsp[-3].bexpr_type).falseList,(yyvsp[-1].ival));
			(yyval.bexpr_type).trueList = merge((yyvsp[-3].bexpr_type).trueList, (yyvsp[0].bexpr_type).trueList);
			(yyval.bexpr_type).falseList = (yyvsp[0].bexpr_type).falseList;
		}
	}
#line 1670 "com.tab.c" /* yacc.c:1646  */
    break;

  case 34:
#line 360 "com.y" /* yacc.c:1646  */
    {
		string op ((yyvsp[-1].aopval));
		(yyval.bexpr_type).trueList = new vector<int>();
		(yyval.bexpr_type).trueList ->push_back (codeList.size());
		(yyval.bexpr_type).falseList = new vector<int>();
		(yyval.bexpr_type).falseList->push_back(codeList.size()+1);
		writeCode(getOp(op)+ " ");
		writeCode("goto ");
	}
#line 1684 "com.tab.c" /* yacc.c:1646  */
    break;

  case 35:
#line 372 "com.y" /* yacc.c:1646  */
    {
	(yyval.ival) = codeList.size();
	writeCode("goto ");
}
#line 1693 "com.tab.c" /* yacc.c:1646  */
    break;

  case 40:
#line 399 "com.y" /* yacc.c:1646  */
    {
		backpatch((yyvsp[-7].bexpr_type).trueList,(yyvsp[-4].ival));
		backpatch((yyvsp[-7].bexpr_type).falseList,(yyvsp[0].ival));
		(yyval.stmt_type).nextList = (yyvsp[-3].stmt_type).nextList;
		(yyval.stmt_type).nextList->push_back((yyvsp[-2].ival));
	}
#line 1704 "com.tab.c" /* yacc.c:1646  */
    break;

  case 41:
#line 415 "com.y" /* yacc.c:1646  */
    {
		backpatch((yyvsp[-5].bexpr_type).trueList,(yyvsp[-3].ival));
		backpatch((yyvsp[-5].bexpr_type).falseList,(yyvsp[0].ival));
		(yyval.stmt_type).nextList = (yyvsp[-2].stmt_type).nextList;
		(yyval.stmt_type).nextList->push_back((yyvsp[-1].ival));
	}
#line 1715 "com.tab.c" /* yacc.c:1646  */
    break;

  case 42:
#line 435 "com.y" /* yacc.c:1646  */
    {
		backpatch((yyvsp[-11].bexpr_type).trueList,(yyvsp[-8].ival));
		backpatch((yyvsp[-11].bexpr_type).falseList,(yyvsp[-2].ival));
		(yyval.stmt_type).nextList = merge((yyvsp[-7].stmt_type).nextList, (yyvsp[-1].stmt_type).nextList);
		(yyval.stmt_type).nextList->push_back((yyvsp[-6].ival));
	}
#line 1726 "com.tab.c" /* yacc.c:1646  */
    break;

  case 43:
#line 459 "com.y" /* yacc.c:1646  */
    {
		backpatch((yyvsp[-10].bexpr_type).trueList,(yyvsp[-3].ival));
		vector<int> * v = new vector<int> ();
		v->push_back((yyvsp[-6].ival));
		backpatch(v,(yyvsp[-11].ival));
		v = new vector<int>();
		v->push_back((yyvsp[-1].ival));
		backpatch(v,(yyvsp[-8].ival));
		backpatch((yyvsp[-2].stmt_type).nextList,(yyvsp[-8].ival));
		(yyval.stmt_type).nextList = (yyvsp[-10].bexpr_type).falseList;
	}
#line 1742 "com.tab.c" /* yacc.c:1646  */
    break;

  case 44:
#line 480 "com.y" /* yacc.c:1646  */
    {
		writeCode("goto " + getLabel((yyvsp[-8].ival)));
		backpatch((yyvsp[-1].stmt_type).nextList,(yyvsp[-8].ival));
		backpatch((yyvsp[-5].bexpr_type).trueList,(yyvsp[-2].ival));
		(yyval.stmt_type).nextList = (yyvsp[-5].bexpr_type).falseList;
	}
#line 1753 "com.tab.c" /* yacc.c:1646  */
    break;

  case 45:
#line 497 "com.y" /* yacc.c:1646  */
    {
		writeCode("goto " + getLabel((yyvsp[-10].ival)));
		backpatch((yyvsp[-7].stmt_type).nextList,(yyvsp[-10].ival));
		backpatch((yyvsp[-3].bexpr_type).trueList,(yyvsp[0].ival));
		(yyval.stmt_type).nextList = (yyvsp[-3].bexpr_type).falseList;
	}
#line 1764 "com.tab.c" /* yacc.c:1646  */
    break;


#line 1768 "com.tab.c" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 506 "com.y" /* yacc.c:1906  */


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
