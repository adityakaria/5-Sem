%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
%}
%token ID NUM LE GE EQ NE OR AND WHILE INC DEC BGN END
%right '='
%left AND OR
%left '<' '>' LE GE EQ NE
%left '+''-'
%left '*''/'
%right UMINUS
%left '!'
%%

S       : ST {printf("Input accepted.\n");exit(0);}
         ;
ST     :    WHILE '(' E ')' BGN B END
         ;

B       : E ';' E ';'
        | E ';'
        | B B
        |
        ;

E    : ID'='E
    | E'+'E
    | E'-'E
    | E'*'E
    | E'/'E
    | E'<'E
    | E'>'E
    | E LE E
    | E GE E
    | E EQ E
    | E NE E
    | E OR E
    | E AND E
    | ID
    | E INC
    | E DEC
    | NUM
    ;

%%

#include "lex.yy.c"

int main()
{
printf("Enter the exp: ");
printf("\n");
yyparse();
// lex lex.l; yacc -d yacc.y; cc y.tab.c -ly -ll -lm; ./a.out
}
