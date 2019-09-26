
%{ 
int count = 0;
int max=0;
char *rev;
%} 

space    [ \t\n]

%% 
{space}([A-Za-z])*{space} 		{ if (yyleng>max) {max=yyleng;rev=yytext;}} 
([A-Za-z])*{space} 				{ if (yyleng>max) {max=yyleng;rev=yytext;}} 

.	 							{;} 
%% 


int yywrap(){} 
int main(){ 

yylex(); 

printf("Max size- %d\n", max-1); 
printf("Reversed word:"); 	
for (int i=max-1; i>=0;i--)
	printf("%c",rev[i]);

printf("\n");

return 0; 
} 
