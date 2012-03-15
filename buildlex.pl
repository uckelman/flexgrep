#!/usr/bin/perl -w

# definitions
print <<EOF;
%{
#include <cstdint>
#include <iostream>

uint64_t pos = 0;

#define YY_READ_BUF_SIZE 16777216
%}

%option 8bit main nodefault nounput noyylineno noyymore noyywrap warn

%%

EOF

# rules
while (<ARGV>) {
  chomp;
  print <<"EOF";
$_  std::cout << "@{[$.-1]}@[" << pos << ',' << (pos + yyleng) << "): " << yytext << '\\n'; pos += yyleng;

EOF
}

# catchall rule
print <<EOF;
.|\\n  ++pos; /* eat unmatched chars */

%%
EOF
