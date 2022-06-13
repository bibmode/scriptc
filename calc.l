%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "calc.tab.h"	
%}

%%

"display"                               {return display;}
[0-9]+		                            {yylval.num = atoi(yytext); return number;}
\"([^"]|\\\")*\"                        {
                                          yylval.s = strdup(yytext+1);
                                          if (yylval.s[yyleng-2] != '"')
                                              yyerror("improperly terminated string");
                                          else
                                              yylval.s[yyleng-2] = 0;
                                          return strVal;
                                        }
[ \t\n]                                 ;
[-+/*=():;]   	                        {return yytext[0];}
.		                                    {yyerror("Unexpected Character");}

%%

int yywrap(void) {return 1;}