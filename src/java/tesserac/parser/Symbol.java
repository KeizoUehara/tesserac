package tesserac.parser;

public class Symbol {
	private TokenType type;
	private int line;
	private int column;
	private Object value;

	public Symbol(TokenType type, int line, int column) {
		this.type = type;
		this.line = line;
		this.column = column;
	}

	public Symbol(TokenType type, int line, int column, Object value) {
		this.type = type;
		this.line = line;
		this.column = column;
		this.value = value;
	}

	public TokenType getType() {
		return type;
	}
	public int getLine() {
		return line;
	}

	public int getColumn() {
		return column;
	}

	public String toString() {   
		return "line "+line+", column "+column+",  type = "+type+(value == null ? "" : (", value: '"+value+"'"));
	}
}
