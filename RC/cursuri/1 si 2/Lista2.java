import java.io.*;

public class Lista2 {
  public static void main(String[] sir) throws Exception {
 
    FileInputStream fis = new FileInputStream("lista");
    ObjectInputStream ois = new ObjectInputStream(fis);
    element.p = (element) ois.readObject();

    element Ob = new element();
    System.out.println( Ob.parcurg(element.p) );
    ois.close(); fis.close();
  }
}
