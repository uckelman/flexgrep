CPPFLAGS=-Wall -W -O3
LDFLAGS=
#LFLAGS=-dbBppvCfa
LFLAGS=-bBppvCfa
CC=g++

lexer: lex.yy.o 
	$(CC) $(LDFLAGS) -o $@ $^

lex.yy.c: lexer.l
	$(LEX) $(LFLAGS) $<

lexer.l: patterns
	./buildlex.pl $< >$@

.PHONY: clean

clean:
	-rm *.o lex.yy.c lex.backup lexer lexer.l
