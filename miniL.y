/* cs152-miniL phase2 */
%{
#include "heading.h"
%}

%{
void yyerror(const char *msg);
extern int currLine;
extern int pos;
%}

//Bison
%union{ 
    char * oper_val
    int * int_val
%}

%error-verbose
%start prog_start
%token FUNCTION
%token BEGIN_PARAMS
%token END_PARAMS
%token BEGIN_LOCALS
%token END_LOCALS
%token BEGIN_BODY
%token END_BODY
%token INTEGER
%token ARRAY
%token ENUM
%token OF
%token IF
%token THEN
%token ENDIF
%token ELSE
%token FOR
%token WHILE
%token DO
%token BEGIN_LOOP
%token END_LOOP
%token CONTINUE
%token READ
%token WRITE
%token AND
%token OR
%token NOT
%token TRUE
%token FALSE
%token RETURN
%token SUB
%token ADD
%token MULT
%token EQ
%token NEQ
%token LT
%token GT
%token LTE
%token GTE
%token SEMICOLON
%token COLON
%token COMMA
%token L_PAREN
%token R_PAREN
%token L_SQUARE_BRACKET
%token R_SQUARE_BRACKET
%token ASSIGN

%%

prog_start:
	functions
		{printf("prog_start -> functions\n");};

%%

int main(int argc, char **argv) {
   yyparse();
   return 0;
}

void yyerror(const char *msg) {
    /* implement your error handling */
    printf("Error at line %d: %s \n", currLine, pos, msg, )
}
