package tesserac.parser;

public class LetNode extends AST{
	private String name;
	private TypeNode type;
	private AST rhs;
	public LetNode(String name, TypeNode type, AST rhs) {
		this.name = name;
		this.type = type;
		this.rhs = rhs;
	}
	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder("let ");
		sb.append(name);
		if(type!=null){
			sb.append(":");
			sb.append(type);
		}
		sb.append(" = ");
		sb.append(rhs);
		return sb.toString();
	}
}
