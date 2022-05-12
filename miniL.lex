   /* cs152-miniL phase1 */
   
%{   

   /* write your C code here for definitions of variables and including headers */
   int currLine = 1;
   int currPos = 1;
   int numInt = 0;
   int numOp = 0;
   int numPar = 0;
   int numEq = 0;

%}

 /* some common rules */
DIGIT	 [0-9]
INVALID1 {IDENT}_
IDENT    ([a-zA-Z])([a-zA-Z0-9_]*)
INVALID2 [0-9]{IDENT}
COMMENT  ##(.)*


%%
   /* specific lexer rules in regex */
   /* Reserved Word*/

"function"		{printf("FUNCTION\n"); currPos += yyleng;}
"beginparams"		{printf("BEGIN_PARAMS\n"); currPos += yyleng;}
"endparams"  		{printf("END_PARAMS\n"); currPos += yyleng;}
"beginlocals"		{printf("BEGIN_LOCALS\n"); currPos += yyleng;}
"endlocals"		{printf("END_LOCALS\n"); currPos += yyleng;}
"beginbody"		{printf("BEGIN_BODY\n"); currPos += yyleng;}
"endbody"		{printf("END_BODY\n"); currPos += yyleng;}
"integer"		{printf("INTEGER\n"); currPos += yyleng; numInt++;}
"array"			{printf("ARRAY\n"); currPos += yyleng;}
"enum"			{printf("ENUM\n"); currPos += yyleng;}
"of"			{printf("OF\n"); currPos += yyleng;}
"if"			{printf("IF\n"); currPos += yyleng;}
"then"			{printf("THEN\n"); currPos += yyleng;}
"endif"			{printf("ENDIF\n"); currPos += yyleng;}
"else"			{printf("ELSE\n"); currPos += yyleng;}
"for"			{printf("FOR\n"); currPos += yyleng;}
"while"			{printf("WHILE\n"); currPos += yyleng;}
"do"			{printf("DO\n"); currPos += yyleng;}
"beginloop"		{printf("BEGINLOOP\n"); currPos += yyleng;}
"endloop"		{printf("ENDLOOP\n"); currPos += yyleng;}
"continue"		{printf("CONTINUE\n"); currPos += yyleng;}
"read"			{printf("READ\n"); currPos += yyleng;}
"write"			{printf("WRITE\n"); currPos += yyleng;}
"and"			{printf("AND\n"); currPos += yyleng;}
"or"			{printf("OR\n"); currPos += yyleng;}
"not"			{printf("NOT\n"); currPos += yyleng;}
"true"			{printf("TRUE\n"); currPos += yyleng;}
"false"			{printf("FALSE\n"); currPos += yyleng;}
"return"		{printf("RETURN\n"); currPos += yyleng;}

   /* Arithmetic Operators*/
   "-"			{printf("SUB\n"); currPos += yyleng; numOp++;}
   "+"			{printf("ADD\n"); currPos += yyleng; numOp++;}
   "*"			{printf("MULT\n"); currPos += yyleng; numOp++;}
   "/"			{printf("DIV\n"); currPos += yyleng; numOp++;}
   "%"			{printf("MOD\n"); currPos += yyleng; numOp++;}

   /* Comparison Operators*/
   "=="			{printf("EQ\n"); currPos += yyleng; numEq++;}
   "<>"			{printf("NEQ\n"); currPos += yyleng;}
   "<"			{printf("LT\n"); currPos += yyleng;}
   ">"			{printf("GT\n"); currPos += yyleng;}
   "<="			{printf("LTE\n"); currPos += yyleng;}
   ">="			{printf("GTE\n"); currPos += yyleng;}

   /*Other Special Symbols*/
   ";"			{printf("SEMICOLON\n"); currPos += yyleng;}
   ":"			{printf("COLON\n"); currPos += yyleng;}
   ","			{printf("COMMA\n"); currPos += yyleng;}
   "("			{printf("L_PAREN\n"); currPos += yyleng; numPar++;}
   ")"			{printf("R_PAREN\n"); currPos += yyleng; numPar++;}
   "["			{printf("L_SQUARE_BRACKET\n"); currPos += yyleng;}
   "]"			{printf("R_SQUARE_BRACKET\n"); currPos += yyleng;}
   ":="			{printf("ASSIGN\n"); currPos += yyleng;} 

   /*Identifiers and Numbers*/
   {DIGIT}+             {printf("NUMBER %s\n", yytext); currPos += yyleng;}
   {INVALID1}           {printf("ERROR at line %d: identifier %s cannot start with an underscore\n", currLine, yytext); exit(0);}
   {IDENT}              {printf("IDENT %s\n", yytext); currPos += yyleng;}
   " "			{/*Ignore White Space*/ currPos += yyleng;}
   [\t]                 {/*Ignore White Space*/ currPos += yyleng;}
   {COMMENT}            {/*Ignore Comments   */ currLine++; currPos = 1;}
   "\n"                 {/*New Line*/ currLine++; currPos = 1;}
   {INVALID2}           {printf("ERROR at line %d: identifier %s must begin with a letter\n", currLine, yytext); exit(0);}
   .			{printf("ERROR at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}

%%
	/* C functions used in lexer */

int main(int argc, char ** argv)
{
   if(argc >= 2)
   {
   	yyin = fopen(argv[1], "r");
	if(yyin == NULL)
	{
		yyin = stdin;
	}
   	else
   	{
		yyin = stdin;
   	}
   }
   yylex();
   printf("# of Integers    : %d\n", numInt);
   printf("# of Operators   : %d\n", numOp);
   printf("# of Parentheses : %d\n", numPar);
   printf("# of Equal Signs : %d\n", numEq);
}
