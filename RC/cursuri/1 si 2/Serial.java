import java.io.*; 
public class Serial {
  public static void main(String[] sir) 
      throws Exception {
    Angajat.firma = "SRL Serial";
    Angajat Unu = new Angajat("Vasile", 25, 1485);
    Angajat Doi = new Angajat("Ion", 24, 420);
    FileOutputStream fos = new FileOutputStream("Serial");
    ObjectOutputStream oos = new ObjectOutputStream(fos);
    oos.writeUTF(Angajat.firma);
    oos.writeObject(Unu); oos.writeObject(Doi);
    oos.close(); fos.close();
  }
}
