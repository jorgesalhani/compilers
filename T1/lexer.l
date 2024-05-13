%{
  // Contador para indicar a linha (útil para análise de erro)
  int lineCount = 0; 
%}

/* marcadores */
ponto           \.
virgula         ,
pontovirgula    ;
doispontos      :
parentesesDir   \(
parentesesEsq   \)
menorMaior      <> 
maiorEigual     >= 
menorEigual     <= 
maior           > 
menor           <
mais            \+
menos           -
vezes           \*
divisao         \/

/* palavras reservadas */
program   program
begin     begin   
end       end
integer   integer
const     const
var       var
write     write
do        do
else      else
read      read
if        if
then      then

/* utils */
digito    [0-9]+
letra     [a-zA-Z]+

/* tipos comuns */
num       {digito}+
float     {digito}*\.{digito}+
id        ({letra}|_)({letra}|{digito})*
comment   ^\{[*]*$\}


/**/


%%

[ \n\t\r]+        { ;}            // Ignorar whitespaces
{comment}         {lineCount++;}  // Ignorar comentarios

{ponto}           {printf("%s - .\n", yytext); lineCount++;}
{virgula}         {printf("%s - ,\n", yytext); lineCount++;}
{pontovirgula}    {printf("%s - ;\n", yytext); lineCount++;}
{doispontos}      {printf("%s - :\n", yytext); lineCount++;}
{parentesesDir}   {printf("%s - (\n", yytext); lineCount++;}
{parentesesEsq}   {printf("%s - )\n", yytext); lineCount++;}
{menorMaior}      {printf("%s - <>\n", yytext); lineCount++;}
{maiorEigual}     {printf("%s - >=\n", yytext); lineCount++;}
{menorEigual}     {printf("%s - <=\n", yytext); lineCount++;}
{maior}           {printf("%s - >\n", yytext); lineCount++;}
{menor}           {printf("%s - <\n", yytext); lineCount++;}
{mais}            {printf("%s - +\n", yytext); lineCount++;}
{menos}           {printf("%s - -\n", yytext); lineCount++;}
{vezes}           {printf("%s - *\n", yytext); lineCount++;}
{divisao}         {printf("%s - /\n", yytext); lineCount++;}

{program}         {printf("%s - program\n", yytext); lineCount++;}
{begin}           {printf("%s - begin\n", yytext); lineCount++;}
{end}             {printf("%s - end\n", yytext); lineCount++;}
{integer}         {printf("%s - integer\n", yytext); lineCount++;}
{const}           {printf("%s - const\n", yytext); lineCount++;}
{var}             {printf("%s - var\n", yytext); lineCount++;}
{write}           {printf("%s - write\n", yytext); lineCount++;}
{do}              {printf("%s - do\n", yytext); lineCount++;}
{else}            {printf("%s - else\n", yytext); lineCount++;}
{read}            {printf("%s - read\n", yytext); lineCount++;}
{if}              {printf("%s - if\n", yytext); lineCount++;}
{then}            {printf("%s - then\n", yytext); lineCount++;}
  
{id}              {printf("%s - id\n", yytext); lineCount++;}
{num}             {printf("%s - num\n", yytext); lineCount++;}
{float}           {printf("%s - float\n", yytext); lineCount++;}

.                 {printf("%s - erro\n", yytext); lineCount++;}
%%

yywrap() {}

int main() {
  yylex();
  printf("Foram inseridas %d linhas\n", lineCount);

  return 0;
}

