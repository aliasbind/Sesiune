import java.io.*; 
public class Serial1 {   public static void main(String args[]) throws Exception {
    FileInputStream fis = new FileInputStream("Serial");
    ObjectInputStream ois = new ObjectInputStream(fis);
    Angajat.firma = ois.readUTF();
    Angajat Unu = (Angajat) ois.readObject();
    Angajat Doi = (Angajat) ois.readObject();
    Unu.print(); Doi.print();
    ois.close(); fis.close();
  }
}
