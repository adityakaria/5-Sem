#!/bin/sh

lex ex1.l
yacc ex1.y
cc y.tab.c -ly -ll -lm
./a.out

lex lex.l; yacc -d yacc.y; cc y.tab.c -ly -ll -lm; ./a.out
