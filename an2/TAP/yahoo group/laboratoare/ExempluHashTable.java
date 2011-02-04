import java.util.Hashtable;
import java.util.Iterator;

class Profesor{
	String nume, prenume;
	int nrCursuri;
	public Profesor(String nume, String prenume, int nrCursuri){
		this.nume = nume;
		this.prenume = prenume;
		this.nrCursuri = nrCursuri;
	}
	
	public String toString(){
		return nume + " " + prenume + " preda " + nrCursuri + " cursuri";
	}
	
}
public class ExempluHashTable {
	public static void main(String args[]){
		Hashtable<Integer, Profesor> profesori = new Hashtable<Integer,Profesor>();
		profesori.put(1, new Profesor("Anghel","Constantin",2));
		profesori.put(2, new Profesor("Barbu","Emilia",3));
		profesori.put(3, new Profesor("Stanescu","Adrian",3));
		Iterator<Integer> it = profesori.keySet().iterator();
		while(it.hasNext())
			System.out.println(profesori.get(it.next()));
	}

}
