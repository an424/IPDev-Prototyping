
int xMax = 900;
int yMax = 800;

String lorem = "lorem lorem";
String ipsum = "ipsum ipsum";
  
int rndNum = floor(random(20, 40));

Circle[] circ  = new Circle[4];
int[] circleWidth = {620, 480, 340, 300};
int[] circleHeight = {620, 480, 340, 300};

IpsumText[] ipTxt = new IpsumText[rndNum];
LoremText[] loTxt = new LoremText[rndNum];

Line[] lines = new Line[25];


int cb()
{
  return (floor(random(100, 255)));
}

//int[] xPos = {100, 120, 600, 800};

void setup()
{
  size(900, 800);
  background((floor(random(225, 255))), (floor(random(70, 90))), (floor(random(20, 50))));
  
  print(rndNum);
  
  for (int i = 0; i < ipTxt.length; i++)
  {
    int xPos = floor(random(20, 200));
    int yPos = floor(random(0, 800));
    ipTxt[i] = new IpsumText(xPos, yPos);
    
    loTxt[i] = new LoremText(xPos, yPos);
  }
  
  for (int i = 0; i < lines.length; i++)
  {
    int xPos = floor(random(0, xMax));
    lines[i] = new Line(xPos);
  }
  
  for (int i = 0; i < circ.length; i++)
  {
    circ[i] = new Circle(450, 400, circleWidth[i], circleHeight[i]);
  }
}



void draw()
{
  
  for (int x = 0; x < xMax; x += xMax / 5) 
  {
      stroke(cb(), cb(), cb(), (cb() / 2));
      strokeWeight(floor(random(88, 104)));
      line(x, 0, x, xMax);
  }
  
  for (int i = 0; i < ipTxt.length; i++)
  {
    ipTxt[i].displayBox();
    ipTxt[i].displayText();
  }
  
  for (int i = 0; i < loTxt.length; i++)
  {
    loTxt[i].displayBox();
    loTxt[i].displayText();
  }
  
  for (int i = 0; i < lines.length; i++)
  {
    lines[i].displayLine1();
    lines[i].displayLine2();
  }
  
  for (int i = 0; i < circ.length; i++)
  {
    circ[i].display();
  }
}


class Circle
{
  int x;
  int y;
  int w;
  int h;
  
  color c;
  
  private int rndColour()
  {
    return (floor(random(125, 225)));
  }
  
  Circle(int xCo, int yCo, int wdth, int hght)
  {
    x = xCo;
    y = yCo;
    w = wdth;
    h = hght;
    
    c = color(rndColour(), rndColour(), rndColour(), (rndColour() / 2));
  }
  
  void display()
  { 
    fill(c);
    noStroke();
    ellipse(x, y, w, h);
    //print(rndColour);
  }
}


class Line
{
  int x1;
  int y1;
  int x2;
  int y2;
  int x3;
  int y3;
  int x4;
  int y4;
  
  private int rndColour()
  {
    return (floor(random(0, 255)));
  }
  
  Line(int xPos)
  {
    for (int x = 0; x < xMax; x += xMax / 10) 
    {
      x1 = xPos;
      y1 = 800;
      x2 = xPos;
      y2 = 0;
      for (int y = 0; y < xMax; y += xMax / 5) 
      {
        x3 = (xPos * 2);
        y3 = 800;
        x4 = (xPos * 2);
        y4 = 400;
      }
    }
  }
  
  private void displayLine1()
  {
    stroke(rndColour(), rndColour(), rndColour(), rndColour());
    strokeWeight(2);
    line(x1, y1, x2, y2);
    
  }
  
  private void displayLine2()
  {
    stroke(rndColour(), rndColour(), rndColour(), rndColour());
    strokeWeight(2);
    line(x3, y3, x4, y4);
  }
}


class IpsumText
{
  int x;
  int y;
  
  int size()
  {
    return (floor(random(24, 72)));
  }
  
  IpsumText(int xPos, int yPos)
  {
    x = xPos;
    y = yPos;
  }
  
  private void displayBox()
  {
    fill(255, 240, 220, 55);
    noStroke();
    rect(x, y, (size() * 5), size());
  }
  
  private void displayText()
  {
    fill(55, 80, 255, (size() * 2));
    text(ipsum, x, y);
    textSize(size());
    
  }
}


class LoremText
{
  int x;
  int y;
  
  int size()
  {
    return (floor(random(24, 100)));
  }
  
  LoremText(int xPos, int yPos)
  {
    x = (xPos * 7);
    y = yPos;
  }
  
  private void displayBox()
  {
    fill(255, 200, 180, 55);
    noStroke();
    rect(x, y, (size() + 100), size());
  }
  
  private void displayText()
  {
    fill(155, 80, 255, size());
    text(lorem, x, y);
    textSize(size());
    
  }
}
