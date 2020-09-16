mylex: lex.yy.c mylex.h mylex.c
	gcc mylex.c lex.yy.c -ll -o mylex 

lex.yy.c: trial.l
	lex trial.l

