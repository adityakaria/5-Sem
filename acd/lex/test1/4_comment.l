%{ 
    int i,n;
    char c;
%} 
  
%% 
[//]([a-zA-Z])* {printf("");} 
%% 
  
int yywrap(void){} 

int main(int argc, char **argv[]) 
{ 
    yylex(); 
    return 0; 
} 