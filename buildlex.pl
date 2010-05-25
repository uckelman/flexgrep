#!/usr/bin/perl -w

# definitions
print <<EOF;
%{
#include <cstdlib>
#include <iostream>
using namespace std;

void yyerror(char *err);

int pos = 0;
%}

%option 8bit
%option main
%option nodefault
%option nounput
%option warn
%%
EOF

# rules
while (<ARGV>) {
  chomp;
  print <<"EOF";
$_  printf("@{[$.-1]}@[%d,%d): %s\\n", pos, pos + yyleng, yytext); pos += yyleng;
EOF
}

# catchall rules + user code
print <<EOF;
.|\\n  ++pos; /* eat unmatched chars */
%%

void yyerror(char *err)
{
   cerr << err << endl;
   exit(1);
}
EOF
