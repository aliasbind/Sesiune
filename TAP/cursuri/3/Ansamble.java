import java.util.*;

class Ansamble {
  static int[] a; static int n;

  static void combin(int i, int n) {
    int j = i+i, b = a[i];
    while( j<=n ) {
      if( (j<n) && (a[j]<a[j+1]) ) j++;
      if( b>a[j] ) { a[j/2] = b; return; }
      else { a[j/2] = a[j]; j = j+j; } 
    }
    a[j/2] = b;
  }

  public static void main(String[] qqq) {
    int i,b;
    Scanner sc = new Scanner(System.in);
    System.out.print("n = "); n = sc.nextInt();
    a = new int[n+1]; System.out.print("Elementele : ");
    for(i=1; i<=n; i++) a[i] = sc.nextInt();

    for(i=n/2; i>0; i--) combin(i,n);

    for(i=n; i>1; i--) {
      b = a[1]; a[1] = a[i]; a[i] = b; combin(1,i-1);
    }
    for (i=1; i<=n; i++) System.out.print(a[i]+"  ");
    System.out.println();
  }
}
