package tesserac.parser;

import java.io.IOException;
import java.io.StringReader;

import org.junit.Test;

public class LexerTest {

	@Test
	public void test() throws IOException {
		Lexer lexer = new Lexer(new StringReader(
				"if x==1:\n"
			+   "  if y==1:\n"
			+   "    print \"a\"\n"
			+   "  else:\n"
			+   "    print \"b\"\n"
			+   "else:"
			+   "  print \"c\"\n"));
		Symbol yylex = null;
		while((yylex = lexer.getNextSymbol())!=null){
			System.out.println(yylex);
		}

	}

}
