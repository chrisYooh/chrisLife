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
bound               [;(){}]

%%

{ws}                { /* 没有动作， 也不返回 */ }
while               { printf("关键字\t\twhile\t\n"); return (WHILE); }
do                  { printf("关键字\t\tdo\t\n"); return (DO); }
{id}                { printf("变量\t\t%s\t\n", yytext); yylval = installId(); return (ID); }
{number}            { printf("数字\t\t%s\t\n", yytext); yylval = installNum(); return (NUMBER); }
"<"                 { printf("操作符\t\t%s\t\n", yytext); yylval = LT; return (RELOP); }
"<="                { printf("操作符\t\t%s\t\n", yytext); yylval = LE; return (RELOP); }
"="                 { printf("操作符\t\t%s\t\n", yytext); yylval = GE; return (RELOP); }
"<>"                { printf("操作符\t\t%s\t\n", yytext); yylval = NE; return (RELOP); }
">"                 { printf("操作符\t\t%s\t\n", yytext); yylval = GT; return (RELOP); }
">="                { printf("操作符\t\t%s\t\n", yytext); yylval = GE; return (RELOP); }
"-"                 { printf("操作符\t\t%s\t\n", yytext); }
{bound}             { printf("界符\t\t%s\t\n", yytext); }

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
    
    printf("符号类型\t具体值\n");
    
    FILE *fp;
    fp = fopen(argv[1], "r");
    yyin = fp;
    while (yylex () != 0) ;
    fclose(fp);
    return 0;
}
