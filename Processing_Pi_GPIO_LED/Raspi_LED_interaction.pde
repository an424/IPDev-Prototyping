import processing.io.*;

int redLEDp = 22;
int greenLEDp = 27;

boolean redLED = false;
boolean greenLED = false;

Box[] boxes = new Box[2];

color[] c = {
    #ff0066,
    #00ff77,
};
  
void setup()
{
  fullScreen();
  background(110, 150, 255);
  //noCursor();
  
  GPIO.pinMode(redLEDp, GPIO.OUTPUT);
  GPIO.pinMode(greenLEDp, GPIO.OUTPUT);
  
  GPIO.digitalWrite(redLEDp, false);
  GPIO.digitalWrite(greenLEDp, false);
  
  FloatList xPos = new FloatList();
  xPos.set(0, (width / 4.5));
  xPos.set(1, (width / 1.5));
  
  for (int i = 0; i < boxes.length; i++)
  {
    boxes[i] = new Box((xPos.get(i)), (height / 2), 200, 200, c[i]);
  }
}

void draw()
{
  for (int i = 0; i < boxes.length; i++)
  {
    boxes[i].display(c[i]);
  }
}

void mousePressed()
{
  for (int i = 0; i < boxes.length; i++)
  {
    boxes[i].interact();
  }
}


class Box
{
  float x;
  int y;
  int w;
  int h;
  
  color colour;
  Box(float xPos, int yPos, int wdth, int hght, color c)
  {
    x = xPos;
    y = yPos;
    w = wdth;
    h = hght;
    colour = c;
  }
  
  void display(color c)
  {
    noStroke();
    rect(x, y, w, h);
    fill(colour);
    
    colour = c;
  }
  
  void interact()
  {
    if (mouseX > x - w && mouseX < x + w && 
         mouseY < y + h && mouseY > y - h / 2)
    {
       colour = color(255); 
       redLED = !redLED;
       GPIO.digitalWrite(redLEDp, redLED);
       println("clicked"); 
    }
  }
}
