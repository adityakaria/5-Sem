/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

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

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     NUMBER = 258,
     L_BRACKET = 259,
     R_BRACKET = 260,
     DIV = 261,
     MUL = 262,
     ADD = 263,
     SUB = 264,
     EQUALS = 265,
     PI = 266,
     POW = 267,
     SQRT = 268,
     FACTORIAL = 269,
     MOD = 270,
     LOG2 = 271,
     LOG10 = 272,
     FLOOR = 273,
     CEIL = 274,
     ABS = 275,
     COS = 276,
     SIN = 277,
     TAN = 278,
     COSH = 279,
     SINH = 280,
     TANH = 281,
     CEL_TO_FAH = 282,
     FAH_TO_CEL = 283,
     VAR_KEYWORD = 284,
     VARIABLE = 285,
     EOL = 286
   };
#endif
/* Tokens.  */
#define NUMBER 258
#define L_BRACKET 259
#define R_BRACKET 260
#define DIV 261
#define MUL 262
#define ADD 263
#define SUB 264
#define EQUALS 265
#define PI 266
#define POW 267
#define SQRT 268
#define FACTORIAL 269
#define MOD 270
#define LOG2 271
#define LOG10 272
#define FLOOR 273
#define CEIL 274
#define ABS 275
#define COS 276
#define SIN 277
#define TAN 278
#define COSH 279
#define SINH 280
#define TANH 281
#define CEL_TO_FAH 282
#define FAH_TO_CEL 283
#define VAR_KEYWORD 284
#define VARIABLE 285
#define EOL 286




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 29 "gram.y"
{
	int index;
	double num;
}
/* Line 1529 of yacc.c.  */
#line 116 "gram.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

