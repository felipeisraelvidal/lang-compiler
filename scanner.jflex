%%

%unicode
%line
%column
%class LexTest
%function nextToken
%type Token

%{
    private int ntk;

    public int readTokensCount() {
        return ntk;
    }

    private Token symbol(TOKEN_TYPE t) {
        ntk++;
        return new Token(t, yytext(), yyline + 1, yycolumn + 1);
    }

    private Token symbol(TOKEN_TYPE t, String lex, Object value) {
        ntk++;
        return new Token(t, lex, value, yyline + 1, yycolumn + 1);
    }
%}

    endline         =   \r|\n|\r\n;
    blank           =   {endline}|[ \t\f]
    integer         =   [:digit:][:digit:]*
    float           =   {integer}(\.[0-9]*)?
    id              =   [:lowercase:]([:letter:]|[:digit:]|_)*
    typename        =   [:uppercase:]([:letter:]|[:digit:]|_)*
    boolean         =   true|false
    null            =   null
    linecomment     =   "--"(.)*{endline}
    char            =   "\'" + [:letter:]* + "\'" | "\'" [^\\'] "\'" | "\'\\n\'" | "\'\\t\'" | "\'\\b\'" | "\'\\r\'" | "\'\\\\\'" | "\'\\\'\'"
    keyword         =   data|if|else|iterate|read|print|return|new

%state COMMENT

%%

<YYINITIAL>{
    {boolean}           { return symbol(TOKEN_TYPE.BOOLEAN, yytext(), yytext()); }
    {null}              { return symbol(TOKEN_TYPE.NULL, yytext(), yytext()); }
    {keyword}           { return symbol(TOKEN_TYPE.KEYWORD, yytext(), yytext()); }
    {id}                { return symbol(TOKEN_TYPE.ID); }
    {integer}           { return symbol(TOKEN_TYPE.INTEGER, yytext(), Integer.parseInt(yytext())); }
    {float}             { return symbol(TOKEN_TYPE.FLOAT, yytext(), Float.parseFloat(yytext())); }
    {typename}          { return symbol(TOKEN_TYPE.TYPE_NAME, yytext(), yytext()); }
    {char}              { return symbol(TOKEN_TYPE.CHAR, yytext(), (yytext())); }
    "="                 { return symbol(TOKEN_TYPE.ASSIGN); }
    "+"                 { return symbol(TOKEN_TYPE.PLUS); }
    "-"                 { return symbol(TOKEN_TYPE.MINUS); }
    "*"                 { return symbol(TOKEN_TYPE.MULT); }
    "/"                 { return symbol(TOKEN_TYPE.DIV); }
    "%"                 { return symbol(TOKEN_TYPE.MOD); }
    ";"                 { return symbol(TOKEN_TYPE.SEMI); }
    ":"                 { return symbol(TOKEN_TYPE.COLON); }
    ","                 { return symbol(TOKEN_TYPE.COMMA); }
    "."                 { return symbol(TOKEN_TYPE.PERIOD); }
    "("                 { return symbol(TOKEN_TYPE.LPAREN); }
    ")"                 { return symbol(TOKEN_TYPE.RPAREN); }
    "{"                 { return symbol(TOKEN_TYPE.LBRACE); }
    "}"                 { return symbol(TOKEN_TYPE.RBRACE); }
    "["                 { return symbol(TOKEN_TYPE.LBRACKET); }
    "]"                 { return symbol(TOKEN_TYPE.RBRACKET); }
    "&&"                { return symbol(TOKEN_TYPE.LOGICAL_AND); }
    "!"                 { return symbol(TOKEN_TYPE.LOGICAL_NOT); }
    "::"                { return symbol(TOKEN_TYPE.SCOPE_RESOLUTION); }
    "<"                 { return symbol(TOKEN_TYPE.LESS_THAN); }
    ">"                 { return symbol(TOKEN_TYPE.GREATER_THAN); }
    "=="                { return symbol(TOKEN_TYPE.EQUAL_TO); }
    "!="                { return symbol(TOKEN_TYPE.NOT_EQUAL_TO); }
    "{-"                { yybegin(COMMENT); }
    {linecomment}       { }
    {blank}             { }
}

<COMMENT>{
    "-}"                { yybegin(YYINITIAL); }
    [^"-}"]*            { }
}

[^]                     { throw new RuntimeException("Illegal character <"+yytext()+">"); }