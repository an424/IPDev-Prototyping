
Circles circle;
int numChildren = 6;

int xPos = 500;
int yPos = 450;
float radius = 800;
float size = 40;

boolean clicked = false;
int clickTime = 0;


void setup()
{
  size(1000, 900);
  background(70, 230, 135);
  circle = new Circles(xPos, yPos, radius, size);
  circle.drawCircles();
}

void draw()
{
   circle.onCollision();
}

class Circles
{
  int x;
  int y;
  float r;
  float s;
  
  float[] newRadius = {450.0, 337.5, 253.125, 189.84375, 142.38281, 106.787108};
  
  Circles[] circles = new Circles[0];
  
  Circles(int xPos, int yPos, float radius, float size)
  {
    x = xPos;
    y = yPos;
    recursive(radius, size);
    
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
    stroke(205, 255, 155);
    ellipse(x, y, r, r);
    for (int i = 0; i < circles.length; i++)
    {
      circles[i].drawCircles();
      //newRadius[i] = circles[i].r;
    }
  }
  
  void onCollision()
  {
    for (int i = 0; i < numChildren; i++)
    {
      if(mouseX > x - newRadius[i] && mouseX < x + newRadius[i] && 
          mouseY < y + newRadius[i] && mouseY > y - newRadius[i])
      {
        if (clickTime + (1 * 500) < millis())
        {
           clicked = false;
           if (mousePressed && !clicked)
           { 
             print("Clicked");
             //circ[i].changeColour();
             clickTime = millis();
             clicked = true;
           }
        }
      }
    }
  }
}
