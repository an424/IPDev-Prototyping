
let width = window.innerWidth;
let height = window.innerHeight;

let cnvsHeight;

let cubes = [];

let overCube = false;
let clicked = false;

let socket;

function setup()
{
	socket = io.connect('http://localhost:3000');
	cnvsHeight = height / 3;
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
		}
		else
		{
			overCube = false;
			
			// console.log('Not Over Object');
			// loop();
		}	
	}

	pressed(clicked)
	{
		if (clicked)
		{
		return;
		}
		else
		{	
			console.log('Object Pressed');
			toMax();
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
				cubes[i].pressed(clicked);
				clicked = true;
				setTimeout(d = function() {
					clicked = false;
				}, 250);
			}
		}
	}
}


function toMax()
{
	
	let value = Math.floor(random(0, 20));
	socket.emit('click', value);

	console.log('Clicked value: ' + value);
	
}


