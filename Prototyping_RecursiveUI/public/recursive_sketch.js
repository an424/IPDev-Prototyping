var width;
var height;

function setup()
{
	width = window.innerWidth;
	height = window.innerHeight;

	let radius = width / 2;
	let size = width / 100;

	createCanvas(width, height);
	background(100, 225, 175);
	let x = width / 2;
	let y = height / 2;
	recursive(x, y, radius, size);
}

function windowResized() 
{
  resizeCanvas(width, height);
}

function touchMoved()
{
	return false;
}

function touchEnded()
{
	return false;
}

function recursive(x, y, radius, size)
{
	noFill();
	stroke(225, 255, 50);
	strokeWeight(size);
	ellipse(x, y, radius, radius);
	if (radius > 2.)
	{
		radius *= 0.75;
		size *= 0.75;
		recursive(x, y, radius, size);
	}
}
