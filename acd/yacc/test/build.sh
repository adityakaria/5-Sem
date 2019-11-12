#!/bin/sh

lex lex.l;
yacc -d yacc.y;
cc y.tab.c -ly -ll -lm;
./a.out
