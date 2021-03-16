
let width = window.innerWidth;
let height = window.innerHeight;

let cnvsHeight;

let cubes = [];

var overCube = false;
let clicked = false;

let socket;

var index;

function setup()
{
	socket = io.connect('http://192.168.0.11:3000');
	cnvsHeight = height / 4;
	createCanvas(width, height);
	for (let i = 0; i < 6; i++) 
	{
		cubes[i] = new Cube();
	}
}


class Cube 
{
	constructor() 
	{
		this.x = random(width);
		this.y = random(cnvsHeight, height);
		this.z = random(25, 45);
	}
	
	display(clicked)
	{
		noStroke();
		rectMode(RADIUS);
		rect(this.x, this.y, this.z, this.z);
		fill(255, 255, 225);

		if (mouseX > this.x - this.z 
			&& mouseX < this.x + this.z
			&& mouseY > this.y - this.z 
			&& mouseY < this.y + this.z)
		{
			overCube = true;
			clicked = false;
			console.log(overCube);
		}
		else
		{
			overCube = false;
		}	
	}

	pressed(clicked, index)
	{
		fill(255, 230, 180);

		if (clicked)
		{
		return;
		}
		else
		{	
			console.log('Object Pressed');
			console.log('Cube No: ' + index);
			toMax(index);
		}

		console.log('clicked');		
	}
}

function draw()
{
	for (let i = 0; i < cubes.length; i++)
	{
		cubes[i].display(clicked);

		if (overCube)
		{
			if (mouseIsPressed)
			{
				index = i;
				cubes[i].pressed(clicked, index);
				clicked = true;
				setTimeout(function() {
					clicked = false;
				}, 250);
			}
		}
	}
}


// function touchStarted()
// {
//   return false;
// }

function touchMoved()
{
  return false;
}

// function touchEnded()
// {
//   return false;
// }

document.ontouchmove = function(event) {
    event.preventDefault();
};

function windowResized() {
  resizeCanvas(windowWidth, windowHeight);
}


function toMax(index)
{
	let value = Math.floor(random(25, 75));
	socket.emit('click', value);

	socket.emit('arrIndex', index);

	console.log('Clicked value: ' + value);
}


