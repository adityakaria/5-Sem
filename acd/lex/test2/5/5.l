%{
    #include<stdio.h>
    #include<stdlib.h>
    int c,d,bo=0,bc=0;
    int operator_count,operand_count=0;
%}

operand [a-zA-Z0-9]+
operator [+\-\/*=]
%%

{operator}                          {operator_count++;d++;printf("%s is an operator \n",yytext);} 

{operand}                           {operand_count++;c++;printf("%s is an operand \n",yytext);}

"("                                 {if(bc<=bo)bo++;}

")"                                 {bc++;}

\n                                  {if(operator_count==0){printf("invalid exp");return 0;}      if(bo==bc&&c>d){printf("valid exp");}else {printf("invalid exp");};exit(0);}
%%

void main(){
    yylex();
}
int yywrap(){
    return(1);
}