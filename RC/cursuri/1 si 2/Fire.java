class Tip extends Thread {
  int i;
  Tip(int i) { this.i = i; }

  public void run() {
    for(int k=0; k<200; k++) System.out.print(i + " ");
  }
}

class Fire {
  public static void main(String[] args) {
    Tip Ob1 = new Tip(1), Ob2 = new Tip(2);
    Ob1.run(); Ob2.start();
    for(int k=0; k<200; k++) System.out.print("0 ");
  }
}
