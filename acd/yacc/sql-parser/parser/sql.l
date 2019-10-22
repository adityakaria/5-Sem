alpha [A-Za-z]
digit [0-9]
%%


[ \t\n]
select | 
SELECT              return SELECT;
distinct |
DISTINCT            return DISTINCT;
from |
FROM                return FROM;
where | 
WHERE               return WHERE;
like |
LIKE               return LIKE;
desc |
DESC                return DESC;
as |
AS                  return AS;
asc |
ASC                 return ASC;
join |
JOIN                return JOIN;
on |
ON                  return ON;
"group by" |
"GROUP BY"          return GROUP;
having |
HAVING              return HAVING;
"order by" |
"ORDER BY"          return ORDER;
or |
OR                  return OR;
and |
AND                 return AND;
{digit}+            return NUM;
{alpha}({alpha}|{digit})* return ID;
"<="                return LE;
">="                return GE;
"=="                return EQ;
"!="                return NE;
.                   return yytext[0];

%%