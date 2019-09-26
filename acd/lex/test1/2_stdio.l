%{ 
    int r_count=0,w_count=0;
    char c;
%} 
  
%% 
scanf {
    printf("readf");
    ++r_count;
}
printf {
    printf("writef");
    ++w_count;
}
%% 
  
int yywrap(void){} 

int main(int argc, char **argv[]) 
{ 
    yylex(); 
    printf("Number of scanf: %d\n",r_count);
    printf("Number of printf: %d\n",w_count);
    return 0; 
} 