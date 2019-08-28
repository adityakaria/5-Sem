
%{ 
#include <stdio.h>
int count = 0; 
%} 


%% 
printf\(  {count++;
				printf("writef(");}
scanf\(   {count++;
			printf("readf(");}

%% 


int yywrap(){} 
int main(){ 

yyin=fopen("abc.c","r");

yylex(); 

printf("\n-------------------\nNo. of printf and scanf : %d\n\n",count);
 
return 0; 
} 

