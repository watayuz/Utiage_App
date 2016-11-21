'use strict';

var express = require('express');
var app = express();
var morgan = require('morgan');
var bodyParser = require('body-parser');

var server = require('http').Server(app);
var io = require('socket.io')(server);

var PORT = 8080;

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.static('public'));
app.use(morgan('short'));

app.get('/', function(req, res, next) {
	res.statusCode = 200;
	res.sendfile(__dirname + '/index.html');
	// res.send('hello world');
});

// socket.io
io.on('connection', function(socket) {
	console.log('connection');

	socket.on('onMessage', function(data) {
		// var json = JSON.parse(data);
		// console.log('on data:' + json["name"]);

		// iPhoneへ送信
		io.emit('toiPhone', data);
	});

	socket.on('disconnect', function() {
		console.log('disconnect');
	});
});

server.listen(PORT, function() {
	console.log('server is running : port is 8080');
});