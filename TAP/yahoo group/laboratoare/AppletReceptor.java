package appleti;

import java.applet.Applet;
import java.applet.AppletContext;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Button;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Timer;


public class AppletReceptor extends Applet {
    String mesaj = "", argument1="",argument2="", argument3="", receptionat=""; 
    
    public void init() {
    	setBackground(Color.GRAY);
        mesaj += " S-a apelat init() ";
        if((argument1 = getParameter("param1")) == null)
            argument1 = "Parametrul 1 inexistent";
        if((argument2 = getParameter("param2")) == null)
            argument2 = "Parametrul 2 inexistent";
        if((argument3 = getParameter("param3")) == null)
            argument3 = "Parametrul 3 inexistent";
    }
    
    public void start(){
        mesaj += " S-a apelat start() ";
    }
    
    public void recptioneaza(String mes){
        receptionat = mes;
        repaint();
    }
            
    public void paint(Graphics g){
        //g.setFont(new Font("Courier New", Font.BOLD, 20));
        g.setColor(Color.red);
        g.drawString("Primul exemplu de applet: Receptor", 10, 30);
        g.drawString(argument1, 10, 80);
        g.drawString(argument2, 10, 110);
        g.drawString(argument3, 10, 140);
        g.drawString(receptionat, 10, 170);
        g.drawString(mesaj, 10, 200);
    }        

    public void stop(){
        mesaj += " S-a apelat stop()";
    }
    
    public void destroy(){
    	mesaj += " S-a apelat destroy()";
        System.out.print(mesaj);
    }
}

