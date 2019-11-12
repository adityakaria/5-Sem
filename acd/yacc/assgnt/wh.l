ALPHA [A-Za-z]
DIGIT [0-9]
%%
while                return WHILE;
if      return IF;
else    return ELSE;
or      return OR;
and     return AND;
then    return THEN;
for     return FOR;
{ALPHA}({ALPHA}|{DIGIT})*    return ID;
{DIGIT}+             {yylval=atoi(yytext); return NUM;}
"<="    return LE;
"<"     return LT;
">"     return GT;
">="    return GE;
"=="    return EQ;
"!="    return NE;
"++"    return INC;
"--"    return DEC;
"begin"	return begin;
"end"	return END;
[ \t\n]+                 ;
.                 return yytext[0];
%%