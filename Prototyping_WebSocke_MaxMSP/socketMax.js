const io = require('socket.io-client');
const maxApi = require('max-api');

let socket = io('http://192.168.0.11:3000');;

let indx;
let val;

maxApi.addHandler('connect', (url) => {
	socket = io(url);
});

socket.on('click', (value) =>
{
	val = value;
});

socket.on('arrIndex', (index) =>
{
	indx = index;
	intOut();
});

function intOut()
{
	maxApi.post('arrIndex: ' + indx, 'click: ' + val);
	maxApi.outlet(val, indx);
}

maxApi.addHandler('dissconnect', () => {
	socket.close();
});