alpha [A-Za-z]
digit [0-9]
%%
[ \t\n]
if    return IF;
then    return THEN;
else    return ELSE;
for     return FOR;
while   return WHILE;
switch  return SWITCH;
case    return CASE;
default return DEFAULT;
break   return BREAK;
{digit}+    return NUM;
{alpha}({alpha}|{digit})*    return ID;
"<="    return LE;
">="    return GE;
"=="    return EQ;
"!="    return NE;
"||"    return OR;
"&&"    return AND;
"++"    return INC;
"--"    return DEC;
.    return yytext[0];
%%
