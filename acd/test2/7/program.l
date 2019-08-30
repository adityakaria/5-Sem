 //Implementation of Lexical Analyzer using Lex tool
%{
int COMMENT=0;
%}
identifier [a-zA-Z][a-zA-Z0-9]*
%%
	#.* {printf("\n%s: Preprocessor directive",yytext);}
	int |
	float |
	char |
	double |
	while |
	for |
	struct |
	typedef |
	do |
	if |
	break |
	continue |
	void |
	switch |
	return |
	else |
	goto 									{printf("\n\t%s: Keyword",yytext);}
	"/*" 									{COMMENT=1;}{printf("\n\t %s: COMMENT",yytext);}
	{identifier}\( 							{if(!COMMENT)printf("\nFUNCTION \n\t%s",yytext);}
	\{  									{if(!COMMENT)printf("\n BLOCK BEGINS");}
	\}  									{if(!COMMENT)printf("BLOCK ENDS ");}
	{identifier}(\[[0-9]*\])? 				{if(!COMMENT) printf("\n %s IDENTIFIER",yytext);}
	\".*\" 									{if(!COMMENT)printf("\n\t %s:  STRING",yytext);}
	[0-9]+ 									{if(!COMMENT) printf("\n %s:  NUMBER ",yytext);}
	\)(\:)? 								{if(!COMMENT)printf("\n\t");ECHO;printf("\n");}
	\( ECHO;
	= 										{if(!COMMENT)printf("\n\t %s: ASSIGNMENT OPERATOR",yytext);}
	\<= |
	\>= |
	\< |
	== |
	\> 										{if(!COMMENT) printf("\n\t%s:  RELATIONAL OPERATOR",yytext);}
%%
int main(int argc, char **argv) {
	FILE *file;
	file=fopen("var.c","r");
	if(!file)
	{
	printf("could not open the file");
	exit(0);
	}
	yyin=file;
	yylex();
	printf("\n");
	return(0);
}
int yywrap() {
	return(1);
}