
%{ 
#include <stdio.h>
int count_comm = 0;
int count_id=0; 
int i=0;
%} 


%% 
.*\/\/.*    				{count_comm++;printf("<comments here>");}
.*(int\ ).*(\;)				{	for (i=0;i<yyleng;i++){if (yytext[i]==',') count_id++;} count_id++;printf("<int declared here>");}
.*(char\ ).*(\;)			{	for (i=0;i<yyleng;i++){if (yytext[i]==',') count_id++;} count_id++;printf("<char declared here>");}
.*(float\ ).*(\;)			{	for (i=0;i<yyleng;i++){if (yytext[i]==',') count_id++;} count_id++;printf("<float declared here>");}
.*(double\ ).*(\;)			{	for (i=0;i<yyleng;i++){if (yytext[i]==',') count_id++;} count_id++;printf("<double declared here>");}

%% 


int yywrap(){} 
int main(){ 

yyin=fopen("abc.c","r");

yylex(); 

printf("\n-------------------\nNo. of comments: %d\n\n",count_comm);
printf("\n-------------------\nNo. of identifiers: %d\n\n",count_id);
 
return 0; 
} 

