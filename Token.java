public class Token {
    
    private int l, c;
    private TOKEN_TYPE type;
    private String lexeme;
    private Object info;

    public Token(TOKEN_TYPE t, String lex, Object o, int l, int c) {
        this.type = t;
        this.lexeme = lex;
        this.info = o;
        this.l = l;
        this.c = c;
    }

    public Token(TOKEN_TYPE t, String lex, int l, int c) {
        this.type = t;
        this.lexeme = lex;
        this.l = l;
        this.c = c;
    }

    public Token(TOKEN_TYPE t, Object o, int l, int c) {
        this.type = t;
        this.lexeme = "";
        this.info = o;
        this.l = l;
        this.c = c;
    }

    @Override
    public String toString() {
        return String.format("(%d, %d)\t%s: %s, <%s>", this.l, this.c, this.type, this.lexeme, this.info == null ? "" : this.info.toString());
    }
}
