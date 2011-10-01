import java.util.*;
class varf {      
  int v; varf fiu,frate; static varf rad;
  static Scanner sc = new Scanner(System.in);

  varf() { }
  varf(int val) { v = val; }

  void creare() {
    System.out.print("rad : "); int i = sc.nextInt(); 
    rad = new varf(i); creare(rad);
  }

  void creare(varf x) { // ataseaza fiu si frate lui x
    int i; 
    System.out.print("fiul lui " + x.v + " : "); 
    i = sc.nextInt(); 
    if( i>=0 ) {  // pentru fiu/frate inexistent, i<0
      x.fiu = new varf(i); creare(x.fiu);
    }
    System.out.print("fratele lui " + x.v + " : "); 
    i = sc.nextInt();
    if( i>=0 ) {
      x.frate = new varf(i); creare(x.frate);
    }
  }

  String pre(varf x) {
    if (x==null) return "";
    else return x.v + " " + pre(x.fiu) + pre(x.frate);
  }

  void post(varf x) {
    varf y = x.fiu;
    while (y != null) { post(y); y = y.frate; }
    System.out.print(x.v + " ");
  }
}

class Arbori {
  public static void main(String[] s) {
    varf Ob = new varf(); Ob.creare();
    System.out.println( "Preordine:\t" + Ob.pre(varf.rad) );
    System.out.print("Postordine:\t"); Ob.post(varf.rad);
  }
}
