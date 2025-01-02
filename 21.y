%{
#include <stdio.h>
#include <stdlib.h>
void yyerror(char *);
int yylex(void);
int sym[26];
%}

%token INTEGER VARIABLE
%left '+' '-'
%left '*' '/'

%%

program: 
    | program statement
    ;

statement:
    expr '\n'               { printf("%d\n", $1); }
    | VARIABLE '=' expr '\n' { sym[$1] = $3; }
    | '\n'
    ;

expr:
    INTEGER                 { $$ = $1; }
    | VARIABLE             { $$ = sym[$1]; }
    | expr '+' expr        { $$ = $1 + $3; }
    | expr '-' expr        { $$ = $1 - $3; }
    | expr '*' expr        { $$ = $1 * $3; }
    | expr '/' expr        { $$ = $1 / $3; }
    | '(' expr ')'         { $$ = $2; }
    ;

%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    printf("Calculator Started\n");
    yyparse();
    return 0;
}
