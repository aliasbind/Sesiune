import java.util.Vector;

class Complex{
    private int re,im;
    Complex(int re,int im){
    	this.re=re;
    	this.im=im;
    }
    public String toString(){
    	return " "+re+" + "+im+"i ";
    }
    public boolean equals(Object obj){
    	Complex p=(Complex)obj;
    	return (p.re==re && p.im==im);
    }
    public void setRe(int i){
    	re=i;
    }
    public void setIm(int i){
    	im=i;
    }
}
class ExempluVector{
	public static void main(String arg[]){
		Vector<Complex> v=new Vector<Complex>();
		v.addElement(new Complex(1,2)); //adaugare la sfarsit
		v.addElement(new Complex(2,3));
		System.out.println(v);
		v.add(1,new Complex(4,5)); //adaugare pe pozitia data
		System.out.println(v);
		
		Complex p;
		p=v.elementAt(1);//elementul de pe pozitia 1
		p.setIm(10);
		System.out.println(v);//se modifica si in vector
		
		System.out.println("Nr. elemente "+v.size());//dimensiune vector
		p=v.get(1);//get este echivalenta cu elementAt
		v.removeElementAt(1);//sterge elementul de pe pozitia data
		System.out.println("S-a eliminat "+p);//p.toString()
		System.out.println("Nr. elemente "+v.size());
		System.out.println(v);
		
		v.insertElementAt(new Complex(6,7),1);//echivalent cu add
		System.out.println(v);
		
		p=new Complex(2,3);
		System.out.println(v.indexOf(p));
	}
}