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
malformfloat  {digito}*\..{digito}
num           {digito}+
malformnum    {num}[^{digito}]{id}+
comment       \{.*\}

/**/


%%

[ \n\t\r]+        { ;}            // Ignorar whitespaces
{comment}         {lineCount++;}  // Ignorar comentarios

{ponto}           {printf("%d | %s - simb_ponto\n", lineCount, yytext); lineCount++;}
{virgula}         {printf("%d | %s - simb_virgula\n", lineCount, yytext); lineCount++;}
{pontovirgula}    {printf("%d | %s - simb_ponto_virgula\n", lineCount, yytext); lineCount++;}
{doispontos}      {printf("%d | %s - simb_dois_pontos\n", lineCount, yytext); lineCount++;}
{parentesesDir}   {printf("%d | %s - simb_abre_parentese\n", lineCount, yytext); lineCount++;}
{parentesesEsq}   {printf("%d | %s - simb_fecha_parentese\n", lineCount, yytext); lineCount++;}
{menorMaior}      {printf("%d | %s - <>\n", lineCount, yytext); lineCount++;}
{maiorEigual}     {printf("%d | %s - >=\n", lineCount, yytext); lineCount++;}
{menorEigual}     {printf("%d | %s - <=\n", lineCount, yytext); lineCount++;}
{maior}           {printf("%d | %s - >\n", lineCount, yytext); lineCount++;}
{menor}           {printf("%d | %s - <\n", lineCount, yytext); lineCount++;}
{mais}            {printf("%d | %s - +\n", lineCount, yytext); lineCount++;}
{menos}           {printf("%d | %s - -\n", lineCount, yytext); lineCount++;}
{vezes}           {printf("%d | %s - *\n", lineCount, yytext); lineCount++;}
{divisao}         {printf("%d | %s - /\n", lineCount, yytext); lineCount++;}

{program}         {printf("%d | %s - program\n", lineCount, yytext); lineCount++;}
{begin}           {printf("%d | %s - begin\n", lineCount, yytext); lineCount++;}
{end}             {printf("%d | %s - end\n", lineCount, yytext); lineCount++;}
{integer}         {printf("%d | %s - integer\n", lineCount, yytext); lineCount++;}
{const}           {printf("%d | %s - const\n", lineCount, yytext); lineCount++;}
{var}             {printf("%d | %s - var\n", lineCount, yytext); lineCount++;}
{write}           {printf("%d | %s - write\n", lineCount, yytext); lineCount++;}
{do}              {printf("%d | %s - do\n", lineCount, yytext); lineCount++;}
{else}            {printf("%d | %s - else\n", lineCount, yytext); lineCount++;}
{read}            {printf("%d | %s - read\n", lineCount, yytext); lineCount++;}
{if}              {printf("%d | %s - if\n", lineCount, yytext); lineCount++;}
{then}            {printf("%d | %s - then\n", lineCount, yytext); lineCount++;}
  
{id}              {
                    if (yyleng >= MAX_TOKEN_SIZE) {
                      printf("%d | %s erro: identificador muito grande \n", lineCount, yytext, yyleng); lineCount++;
                    } else {
                      printf("%d | %s - id\n", lineCount, yytext, yyleng); lineCount++;
                    };
                  }

{malformfloat}    {printf("%d | %s - erro: numero real mal formatado\n", lineCount, yytext); lineCount++;}
{malformnum}      {printf("%d | %s - erro: numero inteiro mal formatado\n", lineCount, yytext); lineCount++;}
{num}             {printf("%d | %s - num_int\n", lineCount, yytext); lineCount++;}
{float}           {printf("%d | %s - num_real\n", lineCount, yytext); lineCount++;}

.                 {printf("%d | %s - erro: simbolo nao pertence a linguagem\n", lineCount, yytext); lineCount++;}
%%

int yywrap() {}

int main() {
  printf("line | content\n");
  yylex();

  return 0;
}

