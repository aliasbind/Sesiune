public class Literali {
	static byte byteDefault;
	static short shortDefault;
	static int intDefault;
	static long longDefault;
	static float floatDefault;
	static double doubleDefault; 
	static boolean booleanDefault; 
	static char charDefault;

	static long intregPe64 = 15L;
	static long intregOctal = 017;
	static long intregHexa = 0xF;
	
	static float realPe32 = 45.2f;
	static double realPe64 = 45.2;
	static char caracter = 'a';
	static String sirDeCaractere ="\t un tab si.. \n trecem pe randul urmator ";
	
	public static void main(String[] args) {

		System.out.println(byteDefault);
		System.out.println(shortDefault);
		System.out.println(intDefault);
		System.out.println(floatDefault);
		System.out.println(booleanDefault);
		System.out.println(charDefault);
		System.out.println(intregPe64);
		System.out.println(realPe32);
		System.out.println(realPe64);
		System.out.println(sirDeCaractere);
	}

}
