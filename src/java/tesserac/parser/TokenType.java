package tesserac.parser;

public enum TokenType {
	LineTerminator,
	Keyword,
	WhitesSpace,
	Separator,
	Operator,
	Literal,
	Identifier,
	Indent,
	Dedent,
	EOF
}
