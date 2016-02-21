package tesserac.parser;

public class ConstantNode extends AST{
	private TypeNode type;
	private Object value;
	public ConstantNode(TypeNode type, Object value) {
		this.type = type;
		this.value = value;
	}
	public TypeNode getType() {
		return type;
	}
	public Object getValue() {
		return value;
	}
	@Override
	public String toString() {
		return value.toString();
	}
}
