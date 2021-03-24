import oscP5.*;
import netP5.*;
import gohai.simpletouch.*;
//import processing.io.*;

OscP5 oscP5;
NetAddress server;

SimpleTouch touchscreen;

String message = "/touch/";
OscMessage msg;

Circles circle;
int numChildren = 6;

int xPos;
int yPos;
float radius = 600;
float size = 40;

boolean clicked = false;
int clickTime = 0;

//int mX;
//int mY;


void setup()
{
  fullScreen();
  //noCursor();
  background(255, 115, 100);
  
  String[] devs = SimpleTouch.list();
  
  for (int i = 0; i < devs.length; i++)
  {
    try
    {
      touchscreen = new SimpleTouch(this, devs[i]);
      println("Opened device: " + touchscreen.name());
    }
    catch (RuntimeException e)
    {
      continue;
    }
  }
  
  if (touchscreen == null)
  {
    println("No input devices");
    exit();
  }
  
  xPos = displayWidth / 2;  
  yPos = displayHeight / 2;
  
  oscP5 = new OscP5(this, 7575);
  server = new NetAddress("192.168.0.11", 3743);
  msg = new OscMessage(message);
  
  circle = new Circles(xPos, yPos, radius, size);
  circle.drawCircles();
}

void draw()
{
  float mX = mouseX;
  float mY = mouseY;
  circle.onCollision(mX, mY);
}

float[] newRadius = {106.787108, 142.38281, 189.84375, 253.125, 337.5, 450.0, 600.0};

class Circles
{
  int x;
  int y;
  float r;
  float s;
  color c;
  
  private int rndColour()
  {
    return (floor(random(125, 225)));
  }
  
  Circles[] circles = new Circles[0];
  
  Circles(int xPos, int yPos, float radius, float size)
  {
    x = xPos;
    y = yPos;
    recursive(radius, size);
    
    c = color(255, 255, 125);
    
    if(r > 180)
    {
      circles = new Circles[numChildren];
      for (int i = 0; i < numChildren; i++)
      {
        circles[i] = new Circles(x, y, r, s);
      }
    }
  }
  
  void recursive(float radius, float size)
  {
    r = radius * 0.75f;
    s = size * 0.75f;
  }
  
  void drawCircles()
  {
    noFill();
    strokeWeight(s);
    stroke(c);
    ellipse(x, y, r, r);
    for (int i = 0; i < circles.length; i++)
    {
      circles[i].drawCircles();
      //newRadius[i] = circles[i].r;
    }
  }
  
  void onCollision(float mX, float mY)
  {
    int[] values = {6, 5, 4, 3, 2, 1};
    int intD;
    
    // mX = mouseX;
    // mY = mouseY;
    
    SimpleTouchEvt touches[] = touchscreen.touches();
    //for (SimpleTouchEvt touch : touches)
    //{
    //  println(touch.id);
    //}
    
    for (int i = 0; i < touches.length; i++)
    {
      
    }
    
    float d = dist(mX, mY, x, y);
    intD = int(d);
    
    for (int i = 0; i < numChildren; i++)
    {
      //if (mouseX > x - (newRadius[i] / 2) && mouseX < x + (newRadius[i] / 2) && 
      //    mouseY < y + (newRadius[i] / 2) && mouseY > y - (newRadius[i] / 2))
      //if (d > x - (newRadius[i] / 2) && d < x + (newRadius[i] / 2) && 
      //    d < y + (newRadius[i] / 2) && d > y - (newRadius[i] / 2))
      if (d < 450 / 2)
      {
        //if (clickTime + (1 * 500) < millis())
        //{
          if (msg.get(1) != null)
           {
             println("set");
             msg.clear();
           }
           clicked = false;
           if (mousePressed)
           { 
             //println(values[i]);
             println("Clicked :" + d);
             //oscSend(values[i]);
             oscSend(intD);
             circles[i].changeColour();
             clickTime = millis();
             //clicked = true;
           }
        }
      }
    }
  //}
  
  int changeColour()
  {
    c = color(rndColour(), rndColour(), rndColour());
    return c;
  }
}


void oscSend(int val)
{
  msg = new OscMessage(message);
  msg.add(val);
  oscP5.send(msg, server);
}
