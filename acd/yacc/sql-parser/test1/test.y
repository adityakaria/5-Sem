%{
#include <stdio.h>

void yyerror (const char *str) {
	fprintf(stderr, "error: %s\n", str);
}

int yywrap() {
	return 1;
}

main() {
    // nn@linuxmint ~ $ lex sq.l
    // nn@linuxmint ~ $ yacc -d sq.y
    // nn@linuxmint ~ $ gcc y.tab.c -ll -ly OR gcc -ll y.tab.c lex.yy.c
    // nn@linuxmint ~ $ ./a.out 
    // select name from table2 where name=manav and surname=sanghavi
	yyparse();
}

%}

%%

%token SELECT FROM IDENTIFIER WHERE AND;

line: select items using condition '\n' { printf("Syntax Correct\n"); };

select: SELECT;

items: '*' | identifiers;

identifiers: IDENTIFIER | IDENTIFIER ',' identifiers;

using: FROM IDENTIFIER WHERE;

condition: IDENTIFIER '=' IDENTIFIER | IDENTIFIER '=' IDENTIFIER AND condition;

%%