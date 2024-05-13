%{
  /* definitions */
  #include <string.h>
  #define INT     1
  #define FLOAT   2
  #define IDENTIF 3
  #define ERRO    4

  int lineCount = 0; // Contador para indicar a linha (útil para análise de erro)

  union {
    char string[15];
    int valint;
    float valfloat;
    char carac;
  } yylval;

%}

digito    [0-9]+
letra     [a-zA-Z]+
numint    {digito}+
numfloat  {digito}*\.{digito}+
identif   ({letra}|_)({letra}|{digito})

/* rules */
%%

[ \n\t\r]+        { ;} // Ignorar whitespaces
{numint}        {yylval.valint = atoi(yytext); lineCount++; return INT; }
{numfloat}      {yylval.valfloat = atof(yytext); lineCount++; return FLOAT;}
{identif}       {strcpy(yylval.string, yytext); lineCount++; return IDENTIF;}
.               {yylval.carac = yytext[0]; lineCount++; return ERRO;}
%%

yywrap() {}

int main() {
  int i = 0;
  while (i = yylex()) {
    switch (i) {
      case INT: printf("%d - int\n", yylval.valint); break;
      case FLOAT: printf("%g - float\n", yylval.valfloat); break;
      case IDENTIF: printf("%s - identif\n", yylval.string); break;
      case ERRO: printf("%c - erro\n", yylval.carac); break;
    }
  }
  printf("Foram inseridas %d linhas\n", lineCount);

  return 0;
}

