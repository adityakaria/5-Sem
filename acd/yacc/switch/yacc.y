%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
%}
%token ID NUM SWITCH CASE DEFAULT BREAK LE GE EQ NE OR AND ELSE WHILE IF FOR THEN INC DEC
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
ST     :    SWITCH '(' E ')' '{' B '}'
         ;

B       :    C
         |    C    D
        ;

C      :    C    C
        |    CASE NUM ':' F
        | BREAK ';'
        ;

D      :    DEFAULT    ':' E F ';' BREAK ';'
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
    | IF '(' E ')' THEN '{' F '}'
    | ELSE IF '(' E ')' THEN '{' F '}'
    | ELSE '{' F '}'
    | FOR '(' E ';' E ';' E ')' '{' F '}'
    | WHILE '(' E ')' '{' F '}'
    | E';'
    |
    ;

%%

#include "lex.yy.c"

int main()
{
printf("Enter the exp: ");
yyparse();
}
