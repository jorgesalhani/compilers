build: buildLex

buildLex: lex.yy.c
	cc -o out lex.yy.c -lfl

lex.yy.c: lexer.l
	flex lexer.l

run: 
	./out.exe < ./in/5.in

clean: 
	rm lex.yy.c out *.o