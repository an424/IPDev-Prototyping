
var xMax = 900;
var yMax = 800;

var lorem = "lorem lorem";
var ipsum = "ipsum ipsum";
  
var circ  = [];
var circleXPos = 450;
var circleYPos = 400;
var circleWidth = [620, 480, 340, 300];
var circleHeight = [620, 480, 340, 300];

var ipTxt = [];
var loTxt = [];

var lines = [];

var clicked = false;
var clickTime = 0;

var cb;

function setup()
{
  cb = function()
  {
    return (floor(random(100, 255)));
  }

  var rndNum = floor(random(20, 40));

  createCanvas(900, 800);
  background((floor(random(225, 255))), (floor(random(70, 90))), (floor(random(20, 50))));
  
  console.log(rndNum);
  
  for (let i = 0; i < rndNum; i++)
  {
    let xPos = floor(random(20, 200));
    let yPos = floor(random(0, 800));
    ipTxt[i] = new IpsumText(xPos, yPos);
    
    loTxt[i] = new LoremText(xPos, yPos);
  }
  
  for (let i = 0; i < 25; i++)
  {
    let xPos = floor(random(0, xMax));
    lines[i] = new Line(xPos);
  }
  
  for (let i = 0; i < 4; i++)
  {
    circ[i] = new Circle(450, 400, circleWidth[i], circleHeight[i]);
  }
}



function draw()
{
  
  for (let x = 0; x < xMax; x += xMax / 5) 
  {
      stroke(cb(), cb(), cb(), (cb() / 2));
      strokeWeight(floor(random(88, 120)));
      line(x, 0, x, xMax);
  }
  
  for (let i = 0; i < ipTxt.length; i++)
  {
    ipTxt[i].displayBox();
    ipTxt[i].displayText();
  }
  
  for (let i = 0; i < loTxt.length; i++)
  {
    loTxt[i].displayBox();
    loTxt[i].displayText();
  }
  
  for (let i = 0; i < lines.length; i++)
  {
    lines[i].displayLine1();
    lines[i].displayLine2();
  }
  
  for (let i = 0; i < circ.length; i++)
  {
    circ[i].display();
  }

  for (let i = 0; i < circ.length; i++)
  {
    circ[i].display();
    
    if(mouseX > circleXPos - (circleWidth[i] / 2.25) && mouseX < circleXPos + (circleWidth[i] / 2.25) &&           
            mouseY < circleYPos + (circleHeight[i] / 2.25) && mouseY > circleYPos - (circleHeight[i] / 2.25))
    {
      if (clickTime + (1 * 1000) < millis())
      {
         clicked = false;
         if (mouseIsPressed && !clicked)
         { 
           circ[i].changeColour();
           clickTime = millis();
           clicked = true;
         }
      }
    }
  }
}


class Circle
{
  rndColour()
  {
    return (floor(random(125, 225)));
  }

  constructor(xCo, yCo, wdth, hght)
  {
    this.x = xCo;
    this.y = yCo;
    this.w = wdth;
    this.h = hght;

    this.c = color(this.rndColour(), this.rndColour(), this.rndColour(), (this.rndColour() / 2));
  }
  
  display()
  { 
    fill(this.c);
    noStroke();
    ellipse(this.x, this.y, this.w, this.h);
    //print(rndColour);
  }

  changeColour()
  {
    this.c = color(this.rndColour(), this.rndColour(), this.rndColour(), (this.rndColour() / 2));
  }
}


class Line
{ 
  constructor(xPos)
  {
    for (let x = 0; x < xMax; x += xMax / 10) 
    {
      this.x1 = xPos;
      this.y1 = 800;
      this.x2 = xPos;
      this.y2 = 0;
      for (let y = 0; y < xMax; y += xMax / 5) 
      {
        this.x3 = (xPos * 2);
        this.y3 = 800;
        this.x4 = (xPos * 2);
        this.y4 = 400;
      }
    }
  }
  rndColour = function()
  {
    return (floor(random(0, 255)));
  }
  
  displayLine1()
  {
    stroke(this.rndColour(), this.rndColour(), this.rndColour(), this.rndColour());
    strokeWeight(2);
    line(this.x1, this.y1, this.x2, this.y2);
    
  }
  
  displayLine2()
  {
    stroke(this.rndColour(), this.rndColour(), this.rndColour(), this.rndColour());
    strokeWeight(2);
    line(this.x3, this.y3, this.x4, this.y4);
  }
}


class IpsumText
{
  size = function()
  {
    return (floor(random(24, 72)));
  }
  
  constructor(xPos, yPos)
  {
    this.x = xPos;
    this.y = yPos;
  }
  
  displayBox()
  {
    fill(255, 240, 220, 55);
    noStroke();
    rect(this.x, this.y, (this.size() * 5), this.size());
  }
  
  displayText()
  {
    fill(55, 80, 255, (this.size() * 2));
    text(ipsum, this.x, this.y);
    textSize(this.size());
    
  }
}


class LoremText
{
  size = function()
  {
    return (floor(random(24, 100)));
  }
  
  constructor(xPos, yPos)
  {
    this.x = (xPos * 7);
    this.y = yPos;
  }
  
  displayBox()
  {
    fill(255, 200, 180, 55);
    noStroke();
    rect(this.x, this.y, (this.size() + 100), this.size());
  }
  
  displayText()
  {
    fill(155, 80, 255, this.size());
    text(lorem, this.x, this.y);
    textSize(this.size());
    
  }
}