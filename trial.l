%{
#include "mylex.h"	
%}
%option nounput yylineno



JAVA_LETTER         		[A-Za-z_$]
DIGIT 	                    [0-9]


/* DECIMAL LITERAL */
IntegerTypeSuffix   		[lL]
NON_ZERO_DIGIT              [1-9]
Underscores                 [_]+
DigitOrUnderscore           {DIGIT}|[_]
DigitsAndUnderscores        {DigitOrUnderscore}*
Digits                      {DIGIT}|({DIGIT}({DigitsAndUnderscores}?)({DIGIT}))
DecimalNumeral              0|(({NON_ZERO_DIGIT})({Digits}?))|({NON_ZERO_DIGIT})({Underscores})({Digits})
DecimalIntegerLiteral       ({DecimalNumeral})({IntegerTypeSuffix}?)

/* HEXADECIMAL LITERAL */
HexDigit                    [0-9A-Fa-f]
HexDigitOrUnderscore        {HexDigit}|[_]
HexDigitsAndUnderscores     {HexDigitOrUnderscore}*
HexDigits                   {HexDigit}|({HexDigit}{HexDigitsAndUnderscores}?{HexDigit})
HexNumeral                  (0x{HexDigits})|(0X{HexDigits})
HexIntegerLiteral           ({HexNumeral})({IntegerTypeSuffix}?)

/* OCTAL LITERAL */
OctalDigit                  [0-7]
OctalDigitOrUnderscore      {OctalDigit}|_
OctalDigitsAndUnderscores   {OctalDigitOrUnderscore}*
OctalDigits                 {OctalDigit}|({OctalDigit}{OctalDigitsAndUnderscores}?{OctalDigit})   
OctalNumeral                (0{OctalDigits})|(0{Underscores}{OctalDigits})
OctalIntegerLiteral         ({OctalNumeral})({IntegerTypeSuffix}?)

/* BINARY LITERAL */
BinaryDigit                  [01]
BinaryDigitOrUnderscore      {BinaryDigit}|_
BinaryDigitsAndUnderscores   {BinaryDigitOrUnderscore}*
BinaryDigits                 {BinaryDigit}|({BinaryDigit}{BinaryDigitsAndUnderscores}?{BinaryDigit})
BinaryNumeral                (0b{BinaryDigits})|(0B{BinaryDigits})
BinaryIntegerLiteral         ({BinaryNumeral})({IntegerTypeSuffix}?)

/* FLOATING POINT LITERAL */
Sign                          [+-]
FloatTypeSuffix               [fFdD]
ExponentIndicator             [eE]
SignedInteger                 {Sign}?{Digits}

ExponentPart                  {ExponentIndicator}{SignedInteger}
DecimalFloatingPointLiteral   ({Digits}[.]{Digits}?{ExponentPart}?{FloatTypeSuffix}?)|([.]{Digits}{ExponentPart}?{FloatTypeSuffix}?)|({Digits}{ExponentPart}{FloatTypeSuffix}?)|({Digits}{ExponentPart}?{FloatTypeSuffix})
   
BinaryExponentIndicator       [pP]
BinaryExponent                {BinaryExponentIndicator}{SignedInteger}  
HexSignificand                {HexNumeral}|{HexNumeral}.|(0(x|X){HexDigits}?.{HexDigits}) 
HexadecimalFloatingPointLiteral {HexSignificand}{BinaryExponent}{FloatTypeSuffix}?

FloatingPointLiteral            {DecimalFloatingPointLiteral}|{HexadecimalFloatingPointLiteral}

%%
"{"|"}"|"("|")"|";"|","|"."|"["|"]"           					{printf("\n Separator: %s",yytext); return -1;}
"/*"([^*]|"*"+[^/*])*"*/"               						{printf("\n Multiline Comment: %s",yytext);return -1;}
"//"(.)*                       									{printf("\n SingleLine Comment: %s",yytext); return -1;}
"abstract"|"continue"|"for"|"new"|"while"						{printf("\n Keyword: %s",yytext); return -1;}
"switch"|"assert"|"default"|"goto"|"package"					{printf("\n Keyword: %s",yytext); return -1;}
"synchronized"|"boolean"|"do"|"if"|"private"					{printf("\n Keyword: %s",yytext); return -1;}
"this"|"break"|"double"|"implements"|"protected" 				{printf("\n Keyword: %s",yytext); return -1;}
"throw"|"byte"|"else"|"import"|"public" 						{printf("\n Keyword: %s",yytext); return -1;}
"throws"|"case"|"enum"|"instanceof"|"return" 					{printf("\n Keyword: %s",yytext); return -1;}
"transient"|"catch"|"extends"|"int"|"short"						{printf("\n Keyword: %s",yytext); return -1;}
"try"|"char"|"final"|"interface"|"static" 						{printf("\n Keyword: %s",yytext); return -1;}
"void"|"class"|"finally"|"long"|"strictfp" 						{printf("\n Keyword: %s",yytext); return -1;}
"volatile"|"const"|"float"|"native"|"super" 					{printf("\n Keyword: %s",yytext); return -1;}   	         
"++"                            								{printf("\n Increment operator: %s",yytext); return -1;}
"--"                            								{printf("\n Decrement operator: %s",yytext); return -1;}
"~"                             								{printf("\n not operator: %s",yytext); return -1;}
"!"                             								{printf("\n not operator: %s",yytext); return -1;}
"*"                             								{printf("\n multiplication operator: %s",yytext); return -1;}
"/"                             								{printf("\n Division operator: %s",yytext); return -1;}
"%"                             								{printf("\n Modulus operator: %s",yytext); return -1;}
"+"                             								{printf("\n addition operator: %s",yytext); return -1;}
"-"                             								{printf("\n subtraction operator: %s",yytext); return -1;}
">"|"<"|"<="|">="|"instanceof"  								{printf("\n relational operator: %s",yytext); return -1;}
"=="|"!="                       								{printf("\n equality operator: %s",yytext); return -1;}
">>"|"<<"|">>>"                 								{printf("\n shift operator: %s",yytext); return -1;}
"&"                             								{printf("\n Bitwise AND operator: %s",yytext); return -1;}
"^"                             								{printf("\n Bitwise exclusive OR operator: %s",yytext); return -1;}
"|"                             								{printf("\n Bitwise inclusive OR operator: %s",yytext); return -1;}
"&&"                            								{printf("\n Logical AND operator: %s",yytext); return -1;}
"||"                            								{printf("\n Logical OR operator: %s",yytext); return -1;}
"?"|":"                         								{printf("\n ternary operator: %s",yytext); return -1;}
"="|"+="|"-="|"*="|"/="|"%="|"&="|"^="|"|="|"<<="|">>="|">>>="  {printf("\n assignment operator: %s",yytext); return -1;}
"String"		                								{printf("\n Data Type: String"); return -1;}
"null"                          								{printf("\n Null: %s",yytext); return NULL_LITERAL;}
{BinaryIntegerLiteral}          								{printf("\n Integer Constant: %s",yytext); return INTEGER_LITERAL;}
{OctalIntegerLiteral}           								{printf("\n Integer Constant: %s",yytext); return INTEGER_LITERAL;}
{HexIntegerLiteral}             								{printf("\n Integer Constant: %s",yytext); return INTEGER_LITERAL;}
{DecimalIntegerLiteral}         								{printf("\n Integer Constant: %s",yytext); return INTEGER_LITERAL;}
{FloatingPointLiteral}          								{printf("\n Floating-Point Literal: %s",yytext); return FLOAT_LITERAL;}
"true"|"false"                  								{printf("\n Boolean Literal: %s",yytext); return BOOLEAN_LITERAL;}
{JAVA_LETTER}({JAVA_LETTER}|{DIGIT})*   						{printf("\n Identifier: %s",yytext); return IDENTIFIER;}
\"([^"]|("\\"+\"))*+\"                         					{printf("\n String is %s",yytext); return STRING_LITERAL;}
\'(.)\'                          								{printf("\n Character Constant: %s",yytext); return CHAR_LITERAL;}
\n                               								{return -1;}
.                                								{return -1;};
%%
int yywrap(void){
	return 1;
}

/*
TODO:
1. Strings,characters,escape sequences (Before 1pm)
2. readme
3. programs
*/
