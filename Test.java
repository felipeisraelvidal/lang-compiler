import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;

public class Test {

    public static void main(String args[]) throws IOException {
        LexTest lex = new LexTest(new FileReader(args[0]));
        Token t = lex.nextToken();

        PrintWriter writer = new PrintWriter("output.txt", "UTF-8");
        
        while (t != null) {
            writer.println(t.toString());
            System.out.println(t.toString());
            t = lex.nextToken();
        }

        writer.println("\nTokens count: " + lex.readTokensCount());
        System.out.println("\nTokens count: " + lex.readTokensCount());
        writer.close();
    }

}