import oscP5.*;
import netP5.*;
import gohai.simpletouch.*;
//import processing.io.*;

OscP5 oscP5;
NetAddress server;

SimpleTouch touchscreen;

String[] touchMessage = {"/touch/1", "/touch/2", "/touch/3", "/touch/4", "/touch/5", "/touch/6"};
OscMessage[] tchMsg = new OscMessage[6];

Circles circle;
int numChildren = 6;

int xPos;
int yPos;
float radius = 600;
float size = 40;

boolean clicked = false;
int clickTime = 0;

//FloatList tX;
//FloatList tY;

int mX;
int mY;


void setup()
{
  fullScreen();
  noCursor();
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
  
  //tX = new FloatList();
  //tY = new FloatList();
  
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
    IntList intD;
    
    FloatList d;
    FloatList tX;
    FloatList tY;
    
    d = new FloatList();
    tX = new FloatList();
    tY = new FloatList();
    intD = new IntList();
    
    mX = mouseX;
    mY = mouseY; 
    
    
    SimpleTouchEvt touches[] = touchscreen.touches();
    
    for (int i = 0; i < touches.length; i++)
    {
      tchMsg[i] = new OscMessage(touchMessage[i]);
      
      tX.set(i, (map(touches[i].x, 0.0, 1.0, 0.0, displayWidth))); 
      tY.set(i, (map(touches[i].y, 0.0, 1.0, 0.0, displayHeight))); 
      //println("touch x = " + tX);
      //println("touch y = " + tY);
    
      d.set(i, (dist((tX.get(i)), (tY.get(i)), x, y)));
      intD.set(i, (int(d.get(i))));
      
      if ((d.get(i)) < 450 / 2)
      {
        println("clicked = " + d);
        //if ((tX.get(i)) > x - (newRadius[i] / 2) && (tX.get(i)) < x + (newRadius[i] / 2) && 
        //    (tY.get(i)) < y + (newRadius[i] / 2) && (tY.get(i)) > y - (newRadius[i] / 2))
        //if (d > x - (newRadius[i] / 2) && d < x + (newRadius[i] / 2) && 
        //    d < y + (newRadius[i] / 2) && d > y - (newRadius[i] / 2))
        for (int ii = 0; ii < numChildren; ii++) 
        {
          //if (clickTime + (1 * 500) < millis())
          //{
            if (tchMsg[i].get(1) != null)
             {
               println("set");
               tchMsg[i].clear();
             }
             clicked = false;
             //if (mousePressed)
             //{ 
             //println("Clicked :" + d);
             //oscSend(intD[i]);
             tchMsg[i].add(intD.get(i));
             oscP5.send(tchMsg[i], server);
             clickTime = millis();
             //clicked = true;
             if ((tX.get(i)) > x - (newRadius[i] / 2) && (tX.get(i)) < x + (newRadius[i] / 2) && 
                 (tY.get(i)) < y + (newRadius[i] / 2) && (tY.get(i)) > y - (newRadius[i] / 2))
             {
               circles[ii].changeColour();
             }
             //}
          }
        }
      }
    }
  
  int changeColour()
  {
    c = color(rndColour(), rndColour(), rndColour());
    return c;
  }
}


//void oscSend(int val)
//{
//  msg = new OscMessage(message);
//  msg.add(val);
//  oscP5.send(msg, server);
//}
