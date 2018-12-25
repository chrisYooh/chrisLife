%{
    #include <stdio.h>
    #include <stdlib.h>
    #define LT              1
    #define LE              2
    #define EQ              3
    #define NE              4
    #define GT              5
    #define GE              6
    #define WHILE           7
    #define DO              8
    #define ID              9
    #define NUMBER          10
    #define RELOP           11
    int yylval = 0;
    
    int installId();
    int installNum();

%}

/* 正规定义 */
delim               [ \t\n]
ws                  {delim}+
letter              [A-Za-z]
digit               [0-9]
id                  {letter}({letter}|{digit})*
number              {digit}+(\.{digit}+)?(E[+\-]?{digit}+)?

%%

{ws}                { printf("[empty]");/* 没有动作， 也不返回 */ }
while               { printf("[while]"); return (WHILE); }
do                  { printf("[do]"); return (DO); }
{id}                { printf("[id %s]", yytext); yylval = installId(); return (ID); }
{number}            { printf("[number]"); yylval = installNum(); return (NUMBER); }
"<"                 { printf("[lt]"); yylval = LT; return (RELOP); }
"<="                { printf("[le]"); yylval = LE; return (RELOP); }
"="                 { printf("[ge]"); yylval = GE; return (RELOP); }
"<>"                { printf("[ne]"); yylval = NE; return (RELOP); }
">"                 { printf("[gt]"); yylval = GT; return (RELOP); }
">="                { printf("[ge]"); yylval = GE; return (RELOP); }

%%

int installId() {
    return 1;
}

int installNum() {
    return 1;
}

int yywrap(void) {
    printf("\n");
    return 1;
}

int yyerror(char *s) {
    fprintf(stderr, "\nError Input [%s]\n", s);
    return 0;
}

int main(int argc, char *argv[]) {
    FILE *fp;
    fp = fopen(argv[1], "r");
    yyin = fp;
    while (yylex () != 0) ;
    fclose(fp);
    return 0;
}
