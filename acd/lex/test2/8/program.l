%{
        int count=0;
%}

alpha    [a-zA-Z]
digit      [0-9]
space    [ \t\n]
start      ^a

%%
{start}                                    			;
({alpha}|{digit})*(ab){space}    				{count++;}
.                                                      ;
end                                            {return 0;}
%%

int yywrap(){} 
int main()
{
    yylex();
    printf("No. of words ending with ab: %d\n",count);
    return 0;
}