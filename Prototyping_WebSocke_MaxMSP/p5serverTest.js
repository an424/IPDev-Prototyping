const express = require("express");
const app = express();
const cors = require('cors');
const iO = require('socket.io-client');
const http = require("http").Server(app);
const io = require("socket.io")(http);
const port = process.env.PORT || 3000;


var corsOptions = {
    origin: 'http://192.168.0.11:3000',
    optionsSuccessStatus: 200 // For legacy browser support
}

app.use(cors(corsOptions));

app.use(express.static('public'));

console.log('Server is Running');

const maxApi = require('max-api');

io.sockets.on('connection', (function connect(socket) 
{
	maxApi.outletBang();
	maxApi.post('User Connected');
	maxApi.post('connection: ' + socket.id);
	
	socket.on('click', (function intMsg(value) 
	{
		socket.broadcast.emit('click', value);
	}));

	socket.on('arrIndex', (function indexMsg(index) 
	{
		socket.broadcast.emit('arrIndex', index);
	}));
	
	socket.on('disconnect', (function() 
	{
		maxApi.post('User Disconnected');
	}));
}));

http.listen(port, function() 
{
	console.log('listening on ' + port);
});



