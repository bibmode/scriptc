%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int yylex();
void yyerror (char *strError);	
%}

%union {int num; char* s;}

/* %nonassoc yylval */

%start main
%token display
%token <num> number
%token <s> strVal
%type <s> main str
%type <num> exp term factor

%%
main       :    display ':' exp             {printf("%d\n", $3);}
           |    display ':' str             {
                                              printf("%s\n", $3);
                                            }
           ;
exp        :    term                        {$$ = $1;}
           |    exp '+' term                {$$ = $1 + $3;}
           |    exp '-' term                {$$ = $1 - $3;}
           ;
term       :    factor                      {$$ = $1;}
           |    term '*' factor             {$$ = $1 * $3;}
           |    term '/' factor             {$$ = $1 / $3;}
           ;
factor     :    number                      {$$ = $1;}
           |    '(' exp ')'                 {$$ = $2;}
           |    '-' factor                  {$$ = -$2;}
           ;
str        :    strVal                      {$$ = $1;}
           ;

%%

int main(void) {return yyparse();}
void yyerror(char *strError) {
  printf(strError);
}