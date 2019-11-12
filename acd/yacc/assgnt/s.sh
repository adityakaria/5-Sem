lex wh.l
yacc wh.y
gcc y.tab.c -ll -ly
./a.out < ip
