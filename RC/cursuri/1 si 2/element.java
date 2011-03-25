import java.io.*;
import java.util.*;

class element implements Serializable {
  int info; element leg; static element p,u;

  element() { }
  element(int i) { info = i; }

  void creare() {
    element x;
    Scanner sc = new Scanner(System.in); 
    int i = sc.nextInt(); p = new element(i); u = p;
    while ( sc.hasNextInt() ) {
      x = new element( sc.nextInt() ); u.leg = x; u = x; 
    }
    u.leg = p;
  }


  String parcurg(element x) {
    if (x.leg == p) return x.info + "";
    else return x.info + "\t" + parcurg(x.leg);
  }
}
