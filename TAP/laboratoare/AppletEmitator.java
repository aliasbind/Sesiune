package appleti;

import java.applet.Applet;
import java.applet.AppletContext;
import java.awt.Button;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.TextField;

public class AppletEmitator extends Applet{
    Button trimite;
    TextField text;
    
    public void init(){
    	setBackground(Color.GRAY);
    	setLayout(null);

    	trimite = new Button("trimite");
        trimite.setBounds(20, 40, 40, 20);
        trimite.addActionListener(new ActionListener(){
        	   public void actionPerformed(ActionEvent e) {
        	        trimite();
        	    }
        });
        add(trimite);
        
        text = new TextField(20);
        text.setBounds(70, 40, 80, 20);
        add(text);
    }
    
    public void trimite(){
        AppletContext context = getAppletContext();
        AppletReceptor receptor = null;
        int i = 0;
        do{
            receptor = (AppletReceptor) context.getApplet("receptor");
            i++;
            try{
                Thread.sleep(1000);
            }
            catch(InterruptedException e){
            }
        }
        while(i<5 && receptor == null);
        if (receptor != null)
            receptor.recptioneaza(text.getText());
        
    }
    
    public void paint(Graphics g){
        //g.setFont(new Font("Courier New", Font.BOLD, 10));
        
        g.setColor(Color.LIGHT_GRAY);
        g.fillRoundRect(10, 5, 150, 60, 10, 10);
        g.setColor(Color.BLACK);
        g.drawString("Applet Emitator", 20, 20);
        
    }
}
