package tesserac.parser;

import java.io.IOException;
import java.io.StringReader;

import org.junit.Test;

public class ScannerTest {

	@Test
	public void test() throws IOException {
		StringReader reader = new StringReader("let val1 = 12.3\nlet val2 = \"this is test\"");
		Scanner scanner = new Scanner(reader);
		Symbol yylex = null;
		while((yylex = scanner.yylex())!=null){
			System.out.println(yylex);
		}
	}

}
