
%{ 
int COMMENT=0;
%} 
identifier [a-zA-Z][a-zA-Z0-9]*

%% 
\/\/.*								   {COMMENT=1; printf("\n\t %s: COMMENT",yytext);}
{identifier}(\[[0-9]*\])? 				{if(!COMMENT) printf("\n %s IDENTIFIER",yytext);}
= 										{if(!COMMENT)printf("\n\t %s: ASSIGNMENT OPERATOR",yytext);}
\<= |
\>= |
\< |
== |
\> 										{if(!COMMENT) printf("\n\t%s:  RELATIONAL OPERATOR",yytext);}
\+ |
\- |
\* |
\/										{if(!COMMENT) printf("\n\t%s:  OPERATOR",yytext);}

%% 


int yywrap(){}
int main(){
	yylex(); 

	return 0; 
} 
