import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.awt.image.RenderedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;
public class CreareImagine{
public static void main(String args[]){
new CreareImagine();
}
CreareImagine(){
RenderedImage rendImage = creareImagine();
try {
File file = new File("newimage.png");
ImageIO.write(rendImage, "png", file);
file = new File("newimage.jpg");
ImageIO.write(rendImage, "jpg", file);
} catch (IOException e) {
}
}
public RenderedImage creareImagine() {
int width = 100;
int height = 100;
BufferedImage bufferedImage = new BufferedImage(width,
height, BufferedImage.TYPE_INT_RGB);
Graphics2D g2d = bufferedImage.createGraphics();
g2d.setColor(Color.white);
g2d.fillRect(0, 0, width, height);
g2d.setColor(Color.red);
g2d.fillOval(0, 0, width, height);
g2d.dispose();
return bufferedImage;
}
}