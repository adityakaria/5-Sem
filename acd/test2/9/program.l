
%{ 
int count = 0; 
%} 


%% 
(\")[^\"]*(\") {printf("\"STRING\""); 
	count++;}
.	 printf("%s", yytext);
\n {return 0;}
%% 


int yywrap(){} 
int main(){ 

yylex(); 
printf("\nNumber of words "
	"in the given input - %d\n", count); 

return 0; 
} 
