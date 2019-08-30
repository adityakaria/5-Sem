
%{ 
#include <ctype.h>
int count = 0; 
%} 


%% 
[a-u]				{printf("%c",yytext[0]+5);}
[v-z]				{printf("%c",97+5-(97+26-yytext[0]));}
[A-U]				{printf("%c",yytext[0]+5);}
[V-Z]				{printf("%c",65+5-(65+26-yytext[0]));}
end					{return 0;}
%% 


int yywrap(){} 
int main(){ 

yylex(); 


return 0; 
} 
