import java.util.*;

class df {      
  int[][] mat; int n; boolean[] atins;
  df() {
    int i; int[] temp; int ntemp;
    Scanner sc = new Scanner(System.in);
    System.out.print("n = "); n = sc.nextInt();
    mat = new int[n][]; temp = new int[n];
    for (i=0; i<n; i++) {
      System.out.print("Vecinii lui " + i + " : ");
      ntemp = 0;
      while( sc.hasNextInt() ) temp[ntemp++]= sc.nextInt();
      sc.next();
      mat[i] = new int[ntemp];
      for (int j=0; j<ntemp; j++) mat[i][j] = temp[j];
    }
    System.out.println("**************");
  }

  void parcurg() {
    atins = new boolean[n];
    int cc=0, i;
    for (i=0; i<n; i++) atins[i] = false;
    for (i=0; i<n; i++)
      if ( ! atins[i] ) {
        System.out.print("Comp. conexa " + ++cc + " :\t");
        DF(i); System.out.println();
      }
  }
	
  private void DF(int i) {
    int j,k;
    atins[i] = true; System.out.print(i + " ");
    for (j=0; j<mat[i].length; j++)
      { k=mat[i][j]; if ( ! atins[k] ) 
        { System.out.print("("+i+","+k+")"); DF(k); }
      }
  }
}

class ParcDF {
  public static void main(String[] s) {
    df Ob = new df(); Ob.parcurg();
  }
}
