package tesserac.parser;

import java.io.IOException;
import java.io.Reader;
import java.util.Stack;

public class Lexer {
	private Scanner scanner;
	private Stack<Integer> indentStack = new Stack<>();
	private Stack<Symbol> tokenStack = new Stack<>();

	public Lexer(Reader scanner) {
		super();
		this.scanner = new Scanner(scanner);
	}
	private Symbol nextSymbol() throws IOException{
		if(tokenStack.isEmpty()){
			return scanner.yylex();
		}else{
			return tokenStack.pop();
		}
	}
	private void pushSymbol(Symbol symbol){
		tokenStack.push(symbol);
	}
	public Symbol getNextSymbol() throws IOException{
		Symbol symbol = nextSymbol();
		if(symbol.getType() == TokenType.LineTerminator){
			Symbol nextSymbol = nextSymbol();
			pushSymbol(nextSymbol);
			if(nextSymbol.getType() == TokenType.WhitesSpace){
				int currentIndent = indentStack.isEmpty()?0:indentStack.peek();
				int indentLevel = nextSymbol.getValue().toString().length();
				if(currentIndent < indentLevel){
					indentStack.push(indentLevel);
					pushSymbol(new Symbol(TokenType.Indent, nextSymbol.getLine(), 0));
				}else if(currentIndent == indentLevel){
				}else{
					while(currentIndent > indentLevel){
						currentIndent = indentStack.isEmpty()?0:indentStack.pop();
						if(currentIndent<indentLevel){
							throw new IOException("Indent Error");
						}
						pushSymbol(new Symbol(TokenType.Dedent, nextSymbol.getLine(), 0));
					}

				}
			}
		}
		return symbol;
	}
}
