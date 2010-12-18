import java.util.*;

class ArbNiveluri {
  public static void main(String[] s) {
    new nivel();
  }
}

 
class nivel {      
  int[][] mat; int n;

  nivel() {
    int[] temp; int ntemp;
    Scanner sc = new Scanner(System.in);
    System.out.print("n= "); n = sc.nextInt();
    mat = new int[n][]; temp = new int[n];
    for (int i=0; i<n; i++) {
      System.out.print("Fiii lui " + i + " : "); 
      ntemp = 0; 
      while( sc.hasNextInt() ) temp[ntemp++] = sc.nextInt();
      sc.next();
      mat[i] = new int[ntemp];
      for (int j=0; j<ntemp; j++) mat[i][j] = temp[j];
    }
    System.out.println("**************");
    parcurgere();
  }

  void parcurgere() {
    Integer Int; int i,j,k;
    Vector coada = new Vector();
    // radacina este varful 0
    coada.addElement(new Integer(0));
    while ( ! coada.isEmpty() ) {
      Int = (Integer) coada.firstElement(); 
      coada.removeElementAt(0);
      i = Int.intValue(); System.out.print(i+"  ");
      for (k=0; k<mat[i].length; k++) {
        j = mat[i][k]; coada.addElement(new Integer(j));
      }
    }
  }
}
