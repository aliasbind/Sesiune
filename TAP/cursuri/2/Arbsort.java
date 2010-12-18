import java.util.*;
class elem {
  int i; elem st,dr; static elem rad;

  elem() { }
  elem(int ii) { i = ii; }

  void creare() {
    Scanner sc = new Scanner(System.in);
    while ( sc.hasNextInt() ) rad = adaug(rad, sc.nextInt());
  }

  elem adaug(elem x, int i) {
    if (x==null) x=new elem(i);
    else if (i<x.i) x.st=adaug(x.st,i);
         else x.dr=adaug(x.dr,i);
    return x;
  }

  String parcurg(elem x) {
    if (x==null) return("");
    else return( parcurg(x.st) + x.i + " " + parcurg(x.dr));
  }
}

class Arbsort {
  public static void main(String arg[]) { 
    elem Ob = new elem();
    Ob.creare();
    System.out.println(Ob.parcurg(elem.rad));
  }
}
