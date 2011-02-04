import java . awt .*;
import java . awt. event .*;
public class TestMenuEvent extends Frame
implements ActionListener , ItemListener {
public TestMenuEvent ( String titlu ) {
super ( titlu );
MenuBar mb = new MenuBar ();
Menu test = new Menu (" Test ");
Menu edit = new Menu (" Edit ");
CheckboxMenuItem check = new CheckboxMenuItem (" Check!");
test . add( check );
test . addSeparator ();
test . add( new MenuItem (" Exit "));
edit . add( new MenuItem (" Copy "));
edit . add( new MenuItem (" Paste "));
mb. add( test );
mb. add( edit );
setMenuBar (mb);
Button btnExit = new Button (" Exit ");
add ( btnExit , BorderLayout . SOUTH );
setSize (300 , 200) ;
setVisible (true);
test . addActionListener ( this );
check . addItemListener ( this );
btnExit . addActionListener ( this );
}
public void actionPerformed ( ActionEvent e) {
String command = e. getActionCommand ();
if ( command . equals (" Exit "))
System . exit (0);
}
public void itemStateChanged ( ItemEvent e) {
if (e. getStateChange () == ItemEvent . SELECTED )
setTitle (" Checked !");
else
setTitle ("Not checked !");
}
public static void main ( String args []) {
TestMenuEvent f =
new TestMenuEvent("Tratare evenimente meniuri ");
f. setVisible (true);
}
}