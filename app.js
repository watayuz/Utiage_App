'use strict';

var express = require('express');
var app = express();
var server = require('http').Server(app);
var io = require('socket.io')(server);
var morgan = require('morgan');

var PORT = 8080;

app.use(express.static('public'));
app.use(morgan('short'));

app.get('/', function(req, res, next) {
	res.statusCode = 200;
	res.sendfile(__dirname + '/index.html');
	// res.send('hello world');
});

app.post('/', function(req, res, next) {
	console.log('post: ' + req.body);
	res.send('hello');
});

// socket.io
io.on('connection', function(socket) {
	console.log('connection');

	socket.on('onMessage', function(data) {
		console.log('on data:' + data);

		// iPhoneへ送信
		// io.emit('watayuz-iphone', data);
	});

	socket.on('disconnect', function() {
		console.log('disconnect');
	});
});

server.listen(PORT, function() {
	console.log('server is running : port is 8080');
});