CC := g++
CXXFLAGS := -std=c++0x -pedantic -Wall -Wextra -pipe -O3
#CPPFLAGS :=
#LDFLAGS :=

LEX := flex
#LFLAGS := -bBppvCFra
LFLAGS := -BppvCra

.l.cpp:
	$(LEX) $(LFLAGS) -o $@ $<

lexer: lexer.o
	$(CC) -o $@ $(LDFLAGS) $< $(LDLIBS)

lexer.o: lexer.cpp
	$(CXX) -c $(CPPFLAGS) $(CXXFLAGS) -o $@ $<

lexer.l: patterns
	perl -w buildlex.pl $< >$@

# prevent deletion of intermediate file lexer.cpp
.SECONDARY: lexer.cpp

.PHONY: clean

clean:
	$(RM) *.o lexer.cpp lex.backup lexer lexer.l
