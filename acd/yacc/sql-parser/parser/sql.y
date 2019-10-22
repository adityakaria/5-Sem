%{
#include <stdio.h>
#include <stdlib.h>
%}
%token ID NUM SELECT DISTINCT FROM WHERE LE GE EQ NE OR AND LIKE GROUP HAVING ORDER ASC DESC AS JOIN ON
%right '='
%left AND OR
%left '<' '>' LE GE EQ NE

%%

    Statement  : Statement1';' {printf("INPUT ACCEPTED\n");exit(0);};
    Statement1 : SELECT attributeList FROM tableList Statement8
               | SELECT DISTINCT attributeList FROM tableList Statement8
               ;
    Statement2 : WHERE COND Statement3
               | Statement3
               ;
    Statement3 : GROUP attributeList Statement4
               | Statement4
               ;
    Statement4 : HAVING COND Statement5
               | Statement5
               ;
    Statement5 : ORDER attributeList Statement6
               |
               ;
    Statement6 : DESC
               | ASC
               |
               ;
    Statement7  : AS tok
                | tok
                |
                ;
    Statement8  : JOIN tableList ON COND Statement2
                | Statement2
                ;
  attributeList :     ID','attributeList
               | '*'
               | ID Statement7
               ;
 tableList     : ID',' tableList
               | ID Statement7
               ;
    COND    : COND OR COND
               | COND AND COND
               | Compare
               ;
    Compare    : tok '=' tok
               | tok '<' tok 
               | tok '>' tok  
               | tok LE tok 
               | tok GE tok
               | tok EQ tok
               | tok NE tok
               | tok OR tok 
               | tok AND tok 
               | tok LIKE tok 
               ;
    tok        : ID 
               | NUM  
               ;
%%
#include"lex.yy.c"
#include<ctype.h>
main()
{
    printf("Enter the query:");
    yyparse();
}       
// nn@linuxmint ~ $ lex sq.l
// nn@linuxmint ~ $ yacc sq.y
// nn@linuxmint ~ $ gcc y.tab.c -ll -ly
// nn@linuxmint ~ $ ./a.out   
// select name,address from emp where age>20 group by name having age<40 order by name desc
// select name,address from emp as employee where age>20 group by name having age<40 order by name desc;
// select name,address as add from emp as employee where age>20 group by name having age<40 order by name desc;
// select name,address as add from emp as employee join tablename on at1 <= at2 where age>20 group by name having age<40 order by name desc;
// select name,address from emp join tablename on at1 = at2 where age>20 group by name having age<40 order by name desc