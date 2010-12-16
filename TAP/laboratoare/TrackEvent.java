import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.*;
public class TrackEvent extends JApplet {
    private HashMap h = new HashMap();
    private String[] event = {
        "focusGained", "focusLost", "keyPressed",
        "keyReleased", "keyTyped", "mouseClicked",
        "mouseEntered", "mouseExited", "mousePressed",
        "mouseReleased", "mouseDragged", "mouseMoved"
    };
    private MyButton b1 = new MyButton(Color.BLUE, "test1"),
    b2 = new MyButton(Color.RED, "test2");
    class MyButton extends JButton {
        void report(String field, String msg) {
            ((JTextField)h.get(field)).setText(msg);
        }
        FocusListener fl = new FocusListener() {
            public void focusGained(FocusEvent e) {
                report("focusGained", e.paramString());
            }
            public void focusLost(FocusEvent e) {
                report("focusLost", e.paramString());
            }
        };
        KeyListener kl = new KeyListener() {
            public void keyPressed(KeyEvent e) {
                report("keyPressed", e.paramString());
            }
            public void keyReleased(KeyEvent e) {
                report("keyReleased", e.paramString());
            }
            public void keyTyped(KeyEvent e) {
                report("keyTyped", e.paramString());
            }
        };
        MouseListener ml = new MouseListener() {
            public void mouseClicked(MouseEvent e) {
                report("mouseClicked", e.paramString());
            }
            public void mouseEntered(MouseEvent e) {
                report("mouseEntered", e.paramString());
            }
            public void mouseExited(MouseEvent e) {
                report("mouseExited", e.paramString());
            }
            public void mousePressed(MouseEvent e) {
                report("mousePressed", e.paramString());
            }
            public void mouseReleased(MouseEvent e) {
                report("mouseReleased", e.paramString());
            }
        };
        MouseMotionListener mml = new MouseMotionListener() {
            public void mouseDragged(MouseEvent e) {
                report("mouseDragged", e.paramString());
            }
            public void mouseMoved(MouseEvent e) {
                report("mouseMoved", e.paramString());
            }
        };
        public MyButton(Color color, String label) {
            super(label);
            setBackground(color);
            addFocusListener(fl);
            addKeyListener(kl);
            addMouseListener(ml);
            addMouseMotionListener(mml);
        }
    }
    public void init() {
        Container c = getContentPane();
        c.setLayout(new GridLayout(event.length + 1, 2));
        for(int i = 0; i < event.length; i++) {
                JTextField t = new JTextField();
                t.setEditable(false);
                c.add(new JLabel(event[i], JLabel.RIGHT));
                c.add(t);
                h.put(event[i], t);
            }
            c.add(b1);
            c.add(b2);
}
public static void main(String[] args) {
        JApplet j = new TrackEvent();
        JFrame frame = new JFrame("test");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.getContentPane().add(j);
        frame.setSize(700, 500);
        j.init();
        j.start();
        frame.setVisible(true);
    }
}