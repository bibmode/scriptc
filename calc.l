%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "calc.tab.h"	
%}

%%

"print"                                 {return print;}
[0-9]+		                              {yylval.num = atoi(yytext); return number;}
[\t]		                                {;}
\"[^"\n]*["\n]                          {
                                          yylval.s = strdup(yytext); 
                                          return strVal;
                                        }
[-+/*=();]	                            {return yytext[0];}
.		                                    {yyerror("Unexpected Character");}

%%

int yywrap(void) {return 1;}