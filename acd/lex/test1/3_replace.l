%{ 
    int i,n;
    char c;
%} 
  
%% 
[a-zA-Z] {
    for(i=0;yytext[i]!='\0';++i){
        c = yytext[i] + 5;
        if(c>'z'){
            c = 'a' + (c-'z'-1);
        }
        else if (c>'Z' && c<'a'){
            c = 'A' + (c-'Z'-1);
        }
        printf("%c",c);
    }
}
%% 
  
int yywrap(void){} 

int main() 
{ 
    printf("Enter the string of vowels and consonents:"); 
    yylex(); 
    return 0; 
} 