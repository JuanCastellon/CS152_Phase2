   /* cs152-miniL phase1 */
   
%{   

   /* write your C code here for definitions of variables and including headers */
   int currLine = 1;
   int currPos = 1;
   int num;
   char* ident;

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

"function"		{currPos += yyleng; return FUNCTION;}
"beginparams"		{currPos += yyleng; return BEGIN_PARAMS;}
"endparams"  		{currPos += yyleng; return END_PARAMS;}
"beginlocals"		{currPos += yyleng; return BEGIN_LOCALS;}
"endlocals"		{currPos += yyleng; return END_LOCALS;}
"beginbody"		{currPos += yyleng; return BEGIN_BODY;}
"endbody"		{currPos += yyleng; return END_BODY;}
"integer"		{currPos += yyleng; return INTEGER;}
"array"			{currPos += yyleng; return ARRAY;}
"enum"			{currPos += yyleng; return ENUM;}
"of"			{currPos += yyleng; return OF;}
"if"			{currPos += yyleng; return IF;}
"then"			{currPos += yyleng; return THEN;}
"endif"			{currPos += yyleng; return ENDIF;}
"else"			{currPos += yyleng; return ELSE;}
"for"			{currPos += yyleng; return FOR;}
"while"			{currPos += yyleng; return WHILE;}
"do"			{currPos += yyleng; return DO;}
"beginloop"		{currPos += yyleng; return BEGIN_LOOP;}
"endloop"		{currPos += yyleng; return END_LOOP;}
"continue"		{currPos += yyleng; return CONTINUE;}
"read"			{currPos += yyleng; return READ;}
"write"			{currPos += yyleng; return WRITE;}
"and"			{currPos += yyleng; return AND;}
"or"			{currPos += yyleng; return OR;}
"not"			{currPos += yyleng; return NOT;}
"true"			{currPos += yyleng; return TRUE;}
"false"			{currPos += yyleng; return FALSE;}
"return"		{currPos += yyleng; return RETURN;}

   /* Arithmetic Operators*/
   "-"			{currPos += yyleng; return SUB;}
   "+"			{currPos += yyleng; return ADD;}
   "*"			{currPos += yyleng; return MULT;}
   "/"			{currPos += yyleng; return DIV;}
   "%"			{currPos += yyleng; return MOD;}

   /* Comparison Operators*/
   "=="			{currPos += yyleng; return EQ;}
   "<>"			{currPos += yyleng; return NEQ;}
   "<"			{currPos += yyleng; return LT;}
   ">"			{currPos += yyleng; return GT;}
   "<="			{currPos += yyleng; return LTE;}
   ">="			{currPos += yyleng; return GTE;}

   /*Other Special Symbols*/
   ";"			{currPos += yyleng; return SEMICOLON;}
   ":"			{currPos += yyleng; return COLON;}
   ","			{currPos += yyleng; return COMMA;}
   "("			{currPos += yyleng; return L_PAREN;}
   ")"			{currPos += yyleng; return R_PAREN;}
   "["			{currPos += yyleng; return L_SQUARE_BRACKET;}
   "]"			{currPos += yyleng; return R_SQUARE_BRACKET;}
   ":="			{currPos += yyleng; return ASSIGN;} 

   /*Identifiers and Numbers*/
   {DIGIT}+             {currPos += yyleng; number = atoi(yytext); return NUMBER;}
   {INVALID1}           {printf("ERROR at line %d: identifier %s cannot start with an underscore\n", currLine, yytext); exit(0);}
   {IDENT}              {currPos += yyleng; ident = yytext; return IDENT;}
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
}
