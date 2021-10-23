/*
 * Definition of the lexical analyzer
 * author: victorisimoo
 */

/* Definition and description of tokens*/
truev true
falsev false
orv or
andv and
notv not

/* Internal structure of tokens */
%%
[ \t]		; { /* Espacios en blanco */ }
{truev}	{ 
	yylval = 1;
	return true; 
}
{falsev} { 
	yylval = 0;
	return false; 
}
{orv} {return or;}
{andv} {return and;}
{notv} {return not;}
[\)\(\n]	return yytext[0];
.		printf("Error\n");
%%

/* yywrrap method: returns 0 due to lack of entries */
int yywrap(void) {
	return 0;
}