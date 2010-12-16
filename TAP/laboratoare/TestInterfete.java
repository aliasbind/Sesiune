interface I1{
	int x = 0;
	public int f();
}

interface I2 extends I1{
	int y = 1;
	public int g();
}

class Clasa1{
	int z =  2;
	public int h() {
		return z;
	}
}

class Clasa2 extends Clasa1 implements I2{
	int t = 3;
	public int f(){
		return x;
	}
	public int g(){
		return y;
	}
}

public class TestInterfete {
	public static void main(String args[]){
		Clasa2 ob = new Clasa2();
		System.out.println("x = " + ob.f() + " y = " + ob.g() + " z = " + ob.h()); 
		
	}
}
