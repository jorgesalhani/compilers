%{

  /* definitions */
  int count = 0;
%}

/* rules */
%%

[a-zA-Z_][a-zA-Z0-9_]* {printf("%s: Valid\n", yytext); count++;}
.+ {printf("%s: Invalid\n", yytext);}
\n {return 0;}

%%

yywrap() {}

int main() {
  printf("Enter a string: ");
  yylex();
  printf("There were %d vars\n", count);

  return 0;
}

