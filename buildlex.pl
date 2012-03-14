#!/usr/bin/perl -w

# definitions
print <<EOF;
%{
  int pos = 0;
%}

%option 8bit main nodefault nounput noyylineno warn

%%
EOF

# rules
while (<ARGV>) {
  chomp;
  print <<"EOF";
$_  printf("@{[$.-1]}@[%d,%d): %s\\n", pos, pos + yyleng, yytext); pos += yyleng;
EOF
}

# catchall rule
print <<EOF;
.|\\n  ++pos; /* eat unmatched chars */
%%
EOF
