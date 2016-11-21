(function() {
	var socket = io.connect('http://localhost:8080/');
	var button = document.getElementById('emit_message');

	button.addEventListener('click', function() {
		console.log('button clicked');

		var name = document.getElementById('name').value;
		var message = document.getElementById('message').value;
		var str = 'name: ' + name + ' message: ' + message;
		console.log(str);
		sendMessage(str);
	});

	function sendMessage(msg) {
		console.log('send: ' + msg);
		socket.emit('onMessage', {value: msg});
	}
})();