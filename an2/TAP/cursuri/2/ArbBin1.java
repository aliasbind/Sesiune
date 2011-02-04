import java.util.*;

class ArbBin1 {
  public static void main(String[] arfs) {
    ArbBin Ob = new ArbBin();
    Ob.creare();
    System.out.print("Preordine :\t");  Ob.pre(ArbBin.rad);
    System.out.print("\nInordine :\t");   Ob.in(ArbBin.rad);
    System.out.print("\nPostordine :\t"); Ob.post(ArbBin.rad);
  }
}

class ArbBin {
  static int rad; int nv;
  int[] st,dr;

  void creare() {
    Scanner sc = new Scanner(System.in);
    System.out.print("Nr. varfuri : "); nv =  sc.nextInt();
    st = new int[nv]; dr = new int[nv];
    System.out.print("Radacina : "); rad = sc.nextInt();
    for (int i=0; i<nv; i++) {
      System.out.print(" st si dr al varfului " + i + ": ");
      st[i] = sc.nextInt(); dr[i] = sc.nextInt();
    }
  }

  void pre(int x) {
    if( x<0 );
    else { 
      System.out.print(x + "  "); pre(st[x]); pre(dr[x]); 
    }
  }

  void in(int x) {
    if( x<0 );
    else { 
      in(st[x]); System.out.print(x + "  "); in(dr[x]); 
    }
  }

  void post(int x) {
    if( x<0 );
    else { 
      post(st[x]); post(dr[x]); System.out.print(x + "  ");
    }
  }

} 
