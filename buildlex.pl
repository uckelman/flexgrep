#!/usr/bin/perl -w

# definitions
print <<EOF;
%{
#include <cstdint>
#include <iostream>

uint64_t pos = 0;

#define YY_SKIP_YYWRAP

#undef YY_BUF_SIZE
#define YY_BUF_SIZE 16777216

#define YY_READ_BUF_SIZE 16777216

#define YY_INPUT(buf,result,max_size) \\
	errno=0; \\
	while ( (result = read( fileno(yyin), (char *) buf, max_size )) < 0 ) \\
	{ \\
		if( errno != EINTR) \\
		{ \\
			YY_FATAL_ERROR( "input in flex scanner failed" ); \\
			break; \\
		} \\
		errno=0; \\
		clearerr(yyin); \\
	}\\
  std::cerr << pos << std::endl; \\
\\

%}

/* %option 8bit main nodefault nounput noyylineno noyymore noyywrap warn */
%option 8bit main pointer batch noyymore noyywrap case-insensitive

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
