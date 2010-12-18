class Super {
	int camp;
	Super(int camp){
		this.camp=camp;
		metNestaticaDinConstructor();
	}
	static void metStatica() {
		System.out.println("static_Super");
	}
	void metNestatica() {
		System.out.println ("Super");
	}
	void metNestaticaDinConstructor(){
		System.out.println ("Din Constructor Super");
	}
}

class Sub extends Super {
	char camp;
	Sub(int camp){
		super(camp);
		this.camp=(char)camp;
		metNestaticaDinConstructor();
	}
	static void metStatica() {
		System.out.println ("static_Sub");
	}
	void metNestatica() {
		System.out.println("Sub");
	}
	void metNestaticaDinConstructor(){
		System.out.println ("Din Constructor Sub");
	}
}

public class TestPolimorfism {
	public static void main(String[] s) {
		Super ob = new Sub(97);
		ob.metNestatica();
		ob.metStatica();
		System.out.println(ob.camp);
		Sub obSub=(Sub)ob;
		obSub.metNestatica();
		obSub.metStatica();
		System.out.println(obSub.camp);
	}
}