import java.io.*; 
public class Angajat implements Serializable {   String nume; int varsta; int salariu;   static String firma; 	   public Angajat(String n, int v, int s) {   	nume=n; varsta=v; salariu=s;
  }

  public void print() {
System.out.println("Firma:\t\t" + firma + "\n" +
"Nume:\t\t" + nume + "\n" +
"Varsta:\t\t" + varsta + "\n" +
"Salariul:\t" + salariu + "\n");
  }
}
