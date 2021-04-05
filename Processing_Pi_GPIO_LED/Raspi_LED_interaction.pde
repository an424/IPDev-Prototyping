import processing.io.*;

int redLEDp = 27;
int greenLEDp = 22;

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
  background(170, 150, 255);
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
  int boxNo;
  for (int i = 0; i < boxes.length; i++)
  {
    if (i == 0)
    {
      boxNo = 1;
    }
    else
    {
      boxNo = 0;
    }
    
    boxes[i].interact(boxNo);
  }
}

void mouseReleased()
{
  for (int i = 0; i < boxes.length; i++)
  {
    boxes[i].released();
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
  
  boolean redOn;
  boolean greenOn;
  
  void display(color c)
  {
    noStroke();
    rect(x, y, w, h);
    fill(colour);
    
    colour = c;
  }
  
  void interact(int boxNo)
  {
    if (mouseX > x - w && mouseX < x + w && 
         mouseY < y + h && mouseY > y - h / 2)
    {
      if (boxNo == 0)
      {
        colour = color(255); 
        redLED = !redLED;
        GPIO.digitalWrite(redLEDp, redLED);
        redOn = !redOn;
        println("clicked red"); 
      }
      else if (boxNo == 1)
      {
        colour = color(255); 
        greenLED = !greenLED;
        GPIO.digitalWrite(greenLEDp, greenLED);
        greenOn = !greenOn;
        println("clicked green"); 
      }
    }
  }
  
  void released()
  {
    if (redOn)
    {
      redLED = !redLED;
      GPIO.digitalWrite(redLEDp, redLED);
      redOn = !redOn;
    }
    if (greenOn)
    {
      greenLED = !greenLED;
      GPIO.digitalWrite(greenLEDp, greenLED);
      greenOn = !greenOn;
    }
  }
}
