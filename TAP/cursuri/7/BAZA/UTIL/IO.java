package UTIL;
import java.io.*;

public class IO {
  static InputStreamReader reader = 
    new InputStreamReader(System.in);
  static StreamTokenizer f = new StreamTokenizer(reader);
	
  public static double read() {
    try { f.nextToken(); }
    catch (IOException e) { }
    if (f.ttype == -2) return(f.nval);
    else return(Double.NaN);
  }

  public static void readln() {
    try { System.in.read(); }
    catch (IOException e) { }
  }

  public static char readch() { 
    try { return (char) System.in.read(); }
    catch (IOException e) { return '#';}
  }

  public static String readString() {
    try { f.nextToken(); }
    catch(IOException e ) { }
    if (f.ttype == '\"') return(f.sval);
    else return("****");
  }

  public static void writeln() { System.out.println(); }
	
  public static void writeln(String s) { System.out.println(s); }
	
  public static void write(String s) { System.out.print(s); }
}
