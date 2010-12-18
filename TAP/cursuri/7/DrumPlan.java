import java.util.*;

class elem {
  int i,j; elem prec;
  static int m,n,i0,j0,ndepl=4;
  static int[][] mat;
  static int[][] depl = { {1,0,-1,0}, {0,-1,0,1} };
    
  elem() {
	int i,j;
     Scanner sc = new Scanner(System.in);
	System.out.print("m,n = "); m = sc.nextInt(); 
	n = sc.nextInt();     // de fapt m+2,n+2
	mat = new int[m][n];
	for(i=1; i<m-1; i++)
        for(j=1; j<n-1; j++) mat[i][j] = sc.nextInt();
	for (i=0; i<n; i++) {mat[0][i] = 2; mat[m-1][i] = 2; }
	for (j=0; j<m; j++) {mat[j][0] = 2; mat[j][n-1] = 2; }
	System.out.print("i0,j0 = "); 
        i0 = sc.nextInt(); j0 = sc.nextInt();
  }

  elem(int ii, int jj, elem x) { i = ii; j = jj; prec = x; }
  
  String print() {
	if (prec == null) return "(" + i + "," + j + ")";
	else return prec.print() + " " + "(" + i + "," + j + ")";
  }

  void back() { // backtracking pentru celula curenta
    elem x; int ii,jj;
    for (int k=0; k<ndepl; k++) {
      ii = i+depl[0][k]; jj = j+depl[1][k];
      if (mat[ii][jj] == 1);
      else if (mat[ii][jj] == 2) 
        System.out.println(print());
      else if (mat[ii][jj] == 0) {
        mat[i][j] = -1; 
        x = new elem(ii,jj,this); x.back();
        mat[i][j] = 0;
      }
    }
  }
}

class DrumPlan {
  public static void main(String[] args) {
    new elem(); elem start = new elem(elem.i0,elem.j0,null);
    start.back();
  }
}
