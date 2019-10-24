
%{
	#include <stdio.h>
	#include <stdlib.h>
	#include "y.tab.h"
%}

%%

[^ \t\n]+ {yylval.f = yytext; return STR;}
[ \t\n]	 {;}

%%

int yywrap()
{
    return -1;
}

