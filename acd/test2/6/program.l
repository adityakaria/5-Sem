
%{ 
int count = 0; 
%} 


%% 
(and)|(or)|(but)|(yet)|(although)|(because)|(nor)|(for)|(so)   {count=1;}
\n 																{	if (count==1) printf("Compound\n");
																	else printf("Simple\n");
																	return 0;
																}
.																{;}
%% 


int yywrap(){
	return 1;
} 
int main(){ 

yylex(); 
 
return 0; 
} 
