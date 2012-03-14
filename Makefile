CC := gcc
CFLAGS := -pedantic -Wall -Wextra -Wno-unused-function -pipe -O3
#CPPFLAGS :=
#LDFLAGS :=

LEX := flex
#LFLAGS := -bBppvCFra
LFLAGS := -BCra

.l.c:
	$(LEX) $(LFLAGS) -o $@ $<

lexer: lexer.o

lexer.l: patterns
	perl -w buildlex.pl $< >$@

# prevent deletion of intermediate file lexer.c
.SECONDARY: lexer.c

.PHONY: clean

clean:
	$(RM) *.o lexer.c lex.backup lexer lexer.l
