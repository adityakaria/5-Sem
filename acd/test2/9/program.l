
%{ 
int count = 0; 
%} 


%% 
(\")[^\"]*(\") {printf("%s : string\n", yytext); 
	count++;}
.	 ;
\n {return 0;}
%% 


int yywrap(){} 
int main(){ 

yylex(); 
printf("\nNumber of words "
	"in the given input - %d\n", count); 

return 0; 
} 
