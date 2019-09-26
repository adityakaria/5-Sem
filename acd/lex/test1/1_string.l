%{
#include <stdio.h>
#include <string.h>
int longest = 0;
char longword[60];
int i, j, n = 0;
char s[1000], r[1000];
%}
%%
[a-zA-Z]+ { if (yyleng > longest) {
   longest = yyleng;
   strcpy (longword, yytext);
   }
}
. |
\n ;
%%
int main (void) {
   yylex();
   printf("The longest word is %s.\nIt's length is %d.\n",longword, longest);
   strcpy(s,longword);
   while (s[n] != '\0')
      n++;

   j = n - 1;
   for (i = 0; i < n; i++) {
      r[i] = s[j];
      j--;
   }
   
   r[i] = '\0';
   
   printf("Reversed long word is %s\n", r);
   return 0;
}