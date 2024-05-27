%{
  // Contador para indicar a linha (útil para análise de erro)
  int lineCount = 1; 

  // Tamanho maximo para token identificadores (id)
  int MAX_TOKEN_SIZE = 10;
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
float         {digito}*\.{digito}+
id            ({letra}|_)({letra}|{digito}|_)*
malformfloat  {digito}*\.[^{digito}]{id}+
num           {digito}+
malformnum    {num}[^{digito}]{id}+
comment       \{.*\}

/**/


%%

[ \t\r]+          {;}            // Ignorar whitespaces
[ \n]             {lineCount++;}            // Ignorar whitespaces
{comment}         {;}  // Ignorar comentarios

{ponto}           {printf("%d | %s - simb_ponto\n", lineCount, yytext);}
{virgula}         {printf("%d | %s - simb_virgula\n", lineCount, yytext);}
{pontovirgula}    {printf("%d | %s - simb_ponto_virgula\n", lineCount, yytext);}
{doispontos}      {printf("%d | %s - simb_dois_pontos\n", lineCount, yytext);}
{parentesesDir}   {printf("%d | %s - simb_abre_parentese\n", lineCount, yytext);}
{parentesesEsq}   {printf("%d | %s - simb_fecha_parentese\n", lineCount, yytext);}
{menorMaior}      {printf("%d | %s - <>\n", lineCount, yytext);}
{maiorEigual}     {printf("%d | %s - >=\n", lineCount, yytext);}
{menorEigual}     {printf("%d | %s - <=\n", lineCount, yytext);}
{maior}           {printf("%d | %s - >\n", lineCount, yytext);}
{menor}           {printf("%d | %s - <\n", lineCount, yytext);}
{mais}            {printf("%d | %s - +\n", lineCount, yytext);}
{menos}           {printf("%d | %s - -\n", lineCount, yytext);}
{vezes}           {printf("%d | %s - *\n", lineCount, yytext);}
{divisao}         {printf("%d | %s - /\n", lineCount, yytext);}

{program}         {printf("%d | %s - program\n", lineCount, yytext);}
{begin}           {printf("%d | %s - begin\n", lineCount, yytext);}
{end}             {printf("%d | %s - end\n", lineCount, yytext);}
{integer}         {printf("%d | %s - integer\n", lineCount, yytext);}
{const}           {printf("%d | %s - const\n", lineCount, yytext);}
{var}             {printf("%d | %s - var\n", lineCount, yytext);}
{write}           {printf("%d | %s - write\n", lineCount, yytext);}
{do}              {printf("%d | %s - do\n", lineCount, yytext);}
{else}            {printf("%d | %s - else\n", lineCount, yytext);}
{read}            {printf("%d | %s - read\n", lineCount, yytext);}
{if}              {printf("%d | %s - if\n", lineCount, yytext);}
{then}            {printf("%d | %s - then\n", lineCount, yytext);}
  
{id}              {
                    if (yyleng >= MAX_TOKEN_SIZE) {
                      printf("%d | %s erro: identificador muito grande \n", lineCount, yytext, yyleng);
                    } else {
                      printf("%d | %s - id\n", lineCount, yytext, yyleng);
                    };
                  }

{malformfloat}    {printf("%d | %s - erro: numero real mal formatado\n", lineCount, yytext);}
{malformnum}      {printf("%d | %s - erro: numero inteiro mal formatado\n", lineCount, yytext);}
{num}             {printf("%d | %s - num_int\n", lineCount, yytext);}
{float}           {printf("%d | %s - num_real\n", lineCount, yytext);}

.                 {printf("%d | %s - erro: simbolo nao pertence a linguagem\n", lineCount, yytext);}
%%

int yywrap() {}

int main() {
  printf("\n\nSCC0217 - Linguagens de Programação e Compiladores\n");
  printf("==================================================\n\n");
  printf("line | content\n\n");
  yylex();

  return 0;
}

