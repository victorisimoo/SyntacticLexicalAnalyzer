/*
 * Parser definition
 * author: victorisimoo
 */

/* Required libraries and method declarations */
%{
	#include <ctype.h>
	#include <stdio.h>
	
	extern int yylex();
	void yyerror(char *msg);
%}

/* Declaration of tokens priority and elimination of exceptions */
%token false
%token true
%token or
%token and
%token not

/* Statement of grammar rules */
%%
lines	:	lines bexpr '\n' { if($2 == 1){
	printf(": True(1)\n", $2) ;
	}
	else{
	printf("False(0)\n", $2) ;
	}
	}
	| lines '\n'
	| /* empty */;

/* bexpr → bexpr or bterm | bterm */
bexpr	: bexpr or bterm	{ $$ = $1 || $3 }
	| bterm;

/* bterm → bterm and bfactor | bfactor */
bterm	: bterm and bfactor { $$ = $1 && $3 }
	| bfactor;

/* bfactor → not bfactor | (bexpr) | false |true */
bfactor	: not bfactor { $$ = !$2 }
	| '(' bexpr ')' { $$ = $2 }
	| false
	| true;
%%

/* Inclusion of the lexical analyzer */
#include "lex.yy.c"

/*  Method used for syntax error return */
void yyerror(char *msg){
	printf("Error: a syntax error has been detected!");
	exit(0);
}

/* Main method */
int main(){
	yyparse();
	return 0;
}