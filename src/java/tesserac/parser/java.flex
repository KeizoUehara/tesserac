package tesserac.parser;
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Copyright (C) 1998-2015  Gerwin Klein <lsf@jflex.de>                    *
 * All rights reserved.                                                    *
 *                                                                         *
 * License: BSD                                                            *
 *                                                                         *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/* Java 1.2 language lexer specification */

/* Use together with unicode.flex for Unicode preprocesssing */
/* and java12.cup for a Java 1.2 parser                      */

/* Note that this lexer specification is not tuned for speed.
   It is in fact quite slow on integer and floating point literals, 
   because the input is read twice and the methods used to parse
   the numbers are not very fast. 
   For a production quality application (e.g. a Java compiler) 
   this could be optimized */


%%

%public
%class Scanner
%unicode

%line
%column

%type Symbol


%{
  StringBuilder string = new StringBuilder();
  
  private Symbol symbol(TokenType type) {
    return new Symbol(type, yyline+1, yycolumn+1);
  }

  private Symbol symbol(TokenType type, Object value) {
    return new Symbol(type, yyline+1, yycolumn+1, value);
  }

  /** 
   * assumes correct representation of a long value for 
   * specified radix in scanner buffer from <code>start</code> 
   * to <code>end</code> 
   */
  private long parseLong(int start, int end, int radix) {
    long result = 0;
    long digit;

    for (int i = start; i < end; i++) {
      digit  = Character.digit(yycharat(i),radix);
      result*= radix;
      result+= digit;
    }

    return result;
  }
%}

/* main character classes */
LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]

WhiteSpace = [ \t\f]

/* comments */
Comment = {TraditionalComment} | {EndOfLineComment} | 
          {DocumentationComment}

TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
EndOfLineComment = "//" {InputCharacter}* {LineTerminator}?
DocumentationComment = "/*" "*"+ [^/*] ~"*/"

/* identifiers */
Identifier = [:jletter:][:jletterdigit:]*

/* integer literals */
DecIntegerLiteral = 0 | [1-9][0-9]*
DecLongLiteral    = {DecIntegerLiteral} [lL]

HexIntegerLiteral = 0 [xX] 0* {HexDigit} {1,8}
HexLongLiteral    = 0 [xX] 0* {HexDigit} {1,16} [lL]
HexDigit          = [0-9a-fA-F]

OctIntegerLiteral = 0+ [1-3]? {OctDigit} {1,15}
OctLongLiteral    = 0+ 1? {OctDigit} {1,21} [lL]
OctDigit          = [0-7]
    
/* floating point literals */        
FloatLiteral  = ({FLit1}|{FLit2}|{FLit3}) {Exponent}? [fF]
DoubleLiteral = ({FLit1}|{FLit2}|{FLit3}) {Exponent}?

FLit1    = [0-9]+ \. [0-9]* 
FLit2    = \. [0-9]+ 
FLit3    = [0-9]+ 
Exponent = [eE] [+-]? [0-9]+

/* string and character literals */
StringCharacter = [^\r\n\"\\]
SingleCharacter = [^\r\n\'\\]

%state STRING, CHARLITERAL

%%

<YYINITIAL> {

  /* keywords */
  "abstract"                     { return symbol(TokenType.Keyword,yytext()); }
  
  /* boolean literals */
  "true"                         { return symbol(TokenType.Literal, true); }
  "false"                        { return symbol(TokenType.Literal, false); }
  
  /* null literal */
  "null"                         { return symbol(TokenType.Literal,null); }
  
  
  /* separators */
  "("                            { return symbol(TokenType.Separator,yytext()); }
  ")"                            { return symbol(TokenType.Separator,yytext()); }
  "{"                            { return symbol(TokenType.Separator,yytext()); }
  "}"                            { return symbol(TokenType.Separator,yytext()); }
  "["                            { return symbol(TokenType.Separator,yytext()); }
  "]"                            { return symbol(TokenType.Separator,yytext()); }
  ";"                            { return symbol(TokenType.Separator,yytext()); }
  ","                            { return symbol(TokenType.Separator,yytext()); }
  "."                            { return symbol(TokenType.Separator,yytext()); }
  
  /* operators */
  "="                            { return symbol(TokenType.Operator,yytext()); }
  ">"                            { return symbol(TokenType.Operator,yytext()); }
  "<"                            { return symbol(TokenType.Operator,yytext()); }
  "!"                            { return symbol(TokenType.Operator,yytext()); }
  "~"                            { return symbol(TokenType.Operator,yytext()); }
  "?"                            { return symbol(TokenType.Operator,yytext()); }
  ":"                            { return symbol(TokenType.Operator,yytext()); }
  "=="                           { return symbol(TokenType.Operator,yytext()); }
  "<="                           { return symbol(TokenType.Operator,yytext()); }
  ">="                           { return symbol(TokenType.Operator,yytext()); }
  "!="                           { return symbol(TokenType.Operator,yytext()); }
  "&&"                           { return symbol(TokenType.Operator,yytext()); }
  "||"                           { return symbol(TokenType.Operator,yytext()); }
  "++"                           { return symbol(TokenType.Operator,yytext()); }
  "--"                           { return symbol(TokenType.Operator,yytext()); }
  "+"                            { return symbol(TokenType.Operator,yytext()); }
  "-"                            { return symbol(TokenType.Operator,yytext()); }
  "*"                            { return symbol(TokenType.Operator,yytext()); }
  "/"                            { return symbol(TokenType.Operator,yytext()); }
  "&"                            { return symbol(TokenType.Operator,yytext()); }
  "|"                            { return symbol(TokenType.Operator,yytext()); }
  "^"                            { return symbol(TokenType.Operator,yytext()); }
  "%"                            { return symbol(TokenType.Operator,yytext()); }
  "<<"                           { return symbol(TokenType.Operator,yytext()); }
  ">>"                           { return symbol(TokenType.Operator,yytext()); }
  ">>>"                          { return symbol(TokenType.Operator,yytext()); }
  "+="                           { return symbol(TokenType.Operator,yytext()); }
  "-="                           { return symbol(TokenType.Operator,yytext()); }
  "*="                           { return symbol(TokenType.Operator,yytext()); }
  "/="                           { return symbol(TokenType.Operator,yytext()); }
  "&="                           { return symbol(TokenType.Operator,yytext()); }
  "|="                           { return symbol(TokenType.Operator,yytext()); }
  "^="                           { return symbol(TokenType.Operator,yytext()); }
  "%="                           { return symbol(TokenType.Operator,yytext()); }
  "<<="                          { return symbol(TokenType.Operator,yytext()); }
  ">>="                          { return symbol(TokenType.Operator,yytext()); }
  ">>>="                         { return symbol(TokenType.Operator,yytext()); }
  
  /* string literal */
  \"                             { yybegin(STRING); string.setLength(0); }

  /* character literal */
  \'                             { yybegin(CHARLITERAL); }

  /* numeric literals */

  /* This is matched together with the minus, because the number is too big to 
     be represented by a positive integer. */
  "-2147483648"                  { return symbol(TokenType.Literal, new Integer(Integer.MIN_VALUE)); }
  
  {DecIntegerLiteral}            { return symbol(TokenType.Literal, new Integer(yytext())); }
  {DecLongLiteral}               { return symbol(TokenType.Literal, new Long(yytext().substring(0,yylength()-1))); }
  
  {HexIntegerLiteral}            { return symbol(TokenType.Literal, new Integer((int) parseLong(2, yylength(), 16))); }
  {HexLongLiteral}               { return symbol(TokenType.Literal, new Long(parseLong(2, yylength()-1, 16))); }
 
  {OctIntegerLiteral}            { return symbol(TokenType.Literal, new Integer((int) parseLong(0, yylength(), 8))); }  
  {OctLongLiteral}               { return symbol(TokenType.Literal, new Long(parseLong(0, yylength()-1, 8))); }
  
  {FloatLiteral}                 { return symbol(TokenType.Literal, new Float(yytext().substring(0,yylength()-1))); }
  {DoubleLiteral}                { return symbol(TokenType.Literal, new Double(yytext())); }
  {DoubleLiteral}[dD]            { return symbol(TokenType.Literal, new Double(yytext().substring(0,yylength()-1))); }
  
  /* comments */
  {Comment}                      { /* ignore */ }

  /* whitespace */
  {WhiteSpace}                   { return symbol(TokenType.WhitesSpace,yytext()); }
  
  /* LineTerminator */
  {LineTerminator}                   { return symbol(TokenType.LineTerminator); }

  /* identifiers */ 
  {Identifier}                   { return symbol(TokenType.Identifier, yytext()); }  
}

<STRING> {
  \"                             { yybegin(YYINITIAL); return symbol(TokenType.Literal, string.toString()); }
  
  {StringCharacter}+             { string.append( yytext() ); }
  
  /* escape sequences */
  "\\b"                          { string.append( '\b' ); }
  "\\t"                          { string.append( '\t' ); }
  "\\n"                          { string.append( '\n' ); }
  "\\f"                          { string.append( '\f' ); }
  "\\r"                          { string.append( '\r' ); }
  "\\\""                         { string.append( '\"' ); }
  "\\'"                          { string.append( '\'' ); }
  "\\\\"                         { string.append( '\\' ); }
  \\[0-3]?{OctDigit}?{OctDigit}  { char val = (char) Integer.parseInt(yytext().substring(1),8);
                        				   string.append( val ); }
  
  /* error cases */
  \\.                            { throw new RuntimeException("Illegal escape sequence \""+yytext()+"\""); }
  {LineTerminator}               { throw new RuntimeException("Unterminated string at end of line"); }
}

<CHARLITERAL> {
  {SingleCharacter}\'            { yybegin(YYINITIAL); return symbol(TokenType.Literal, yytext().charAt(0)); }
  
  /* escape sequences */
  "\\b"\'                        { yybegin(YYINITIAL); return symbol(TokenType.Literal, '\b');}
  "\\t"\'                        { yybegin(YYINITIAL); return symbol(TokenType.Literal, '\t');}
  "\\n"\'                        { yybegin(YYINITIAL); return symbol(TokenType.Literal, '\n');}
  "\\f"\'                        { yybegin(YYINITIAL); return symbol(TokenType.Literal, '\f');}
  "\\r"\'                        { yybegin(YYINITIAL); return symbol(TokenType.Literal, '\r');}
  "\\\""\'                       { yybegin(YYINITIAL); return symbol(TokenType.Literal, '\"');}
  "\\'"\'                        { yybegin(YYINITIAL); return symbol(TokenType.Literal, '\'');}
  "\\\\"\'                       { yybegin(YYINITIAL); return symbol(TokenType.Literal, '\\'); }
  \\[0-3]?{OctDigit}?{OctDigit}\' { yybegin(YYINITIAL); 
			                              int val = Integer.parseInt(yytext().substring(1,yylength()-1),8);
			                            return symbol(TokenType.Literal, (char)val); }
  
  /* error cases */
  \\.                            { throw new RuntimeException("Illegal escape sequence \""+yytext()+"\""); }
  {LineTerminator}               { throw new RuntimeException("Unterminated character literal at end of line"); }
}

/* error fallback */
[^]                              { throw new RuntimeException("Illegal character \""+yytext()+
                                                              "\" at line "+yyline+", column "+yycolumn); }
