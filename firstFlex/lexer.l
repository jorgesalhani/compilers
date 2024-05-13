%{
  /* definitions */

  int count = 0; // Contador para indicar a linha (útil para análise de erro)
  
%}

digito    [0-9]+
letra     [a-zA-Z]+
numfloat  {digito}*\.{digito}+
identif   ({letra}|_)({letra}|{digito})

/* rules */
%%

[ \n\t]+        { ;} // Ignorar whitespaces
{digito}        {printf("%s: digito\n", yytext); count++;}
{identif}       {printf("%s: identif\n", yytext); count++;}
{numfloat}      {printf("%s: numfloat\n", yytext); count++;}

%%

yywrap() {}

int main() {
  yylex();
  printf("Foram inseridas %d linhas\n", count);

  return 0;
}

