import java.util.*;

class ArbBin2 {
  public static void main(String[] arfs) {
    varf Ob = new varf();
    Ob.creare();
    System.out.print("Preordine :\t");  Ob.pre(varf.rad);
    System.out.print("\nInordine :\t");   Ob.in(varf.rad);
    System.out.print("\nPostordine :\t"); Ob.post(varf.rad);
  }
}

class varf {
  static varf rad; 
  int info; varf st,dr;
  static Scanner sc = new Scanner(System.in);

  varf() { }
  varf(int i) { info = i; }

  void creare() {
    System.out.print("rad : "); rad = new varf(sc.nextInt());
    subarb(rad);
  }

  void subarb(varf x) { // ataseaza subarb. st. si subarb. dr.
    int v;              // v<0 <==> nu exista descendent
    System.out.print("Desc. stang al lui " + x.info + ": "); 
    v = sc.nextInt();
    if( v>=0 ) { x.st = new varf(v); subarb(x.st); }
    System.out.print("Desc. drept al lui " + x.info + ": "); 
    v = sc.nextInt();
    if( v>=0 ) { x.dr = new varf(v); subarb(x.dr); }
  }

  void pre(varf x) {
    if( x == null );
    else { 
      System.out.print(x.info + "  "); pre(x.st); pre(x.dr); 
    }
  }

  void in(varf x) {
    if( x == null );
    else { 
      in(x.st); System.out.print(x.info + "  "); in(x.dr); 
    }
  }

  void post(varf x) {
    if( x == null );
    else { 
      post(x.st); post(x.dr); System.out.print(x.info + "  "); 
    }
  }

} 
