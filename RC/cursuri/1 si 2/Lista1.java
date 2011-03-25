import java.io.*;

public class Lista1 {
  public static void main(String[] sir) throws Exception {
    element Ob = new element(); Ob.creare();
    System.out.println(Ob.parcurg(element.p));
    FileOutputStream fos = new FileOutputStream("lista");
    ObjectOutputStream oos = new ObjectOutputStream(fos);
    oos.writeObject(element.p);
    oos.close(); fos.close();
  }
}
