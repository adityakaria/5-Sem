%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
%}
%token ID NUM SWITCH CASE DEFAULT BREAK LE GE EQ NE OR AND ELSE WHILE IF FOR INC DEC BEGINN END
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
ST     :    WHILE '(' E ')' BEGINN B END
         ;

B       : E ';' E ';'
        | E ';'
        | F
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

F   : F F
    | IF '(' E ')' BEGINN B END
    | ELSE IF '(' E ')' BEGINN B END
    | ELSE BEGINN B END
    | FOR '(' E ';' E ';' E ')' BEGINN B END
    | WHILE '(' E ')' BEGINN B END
    | SWITCH '(' E ')' BEGINN H END
    |
    ;

H       :    I
         |    I    J
        ;

I      :    I    I
        |    CASE NUM ':' B
        | BREAK ';'
        ;

J      :    DEFAULT    ':' E B ';' BREAK ';'
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
