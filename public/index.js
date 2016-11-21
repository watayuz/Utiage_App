(function() {
	var socket = io.connect('http://localhost:8080/');
	var button = document.getElementById('emit_message');

	button.addEventListener('click', function() {
		// console.log('button clicked');

		var name = document.getElementById('name').value;
		var message = document.getElementById('message').value;
		// var str = 'name: ' + name + ' message: ' + message;
		var json = {
			'name': name,
			'message': message
		}
		// console.log(str);
		sendMessage(JSON.stringify(json));
	});

	function sendMessage(json) {
		// console.log('send: ' + msg);
		// var json = JSON.stringify({value: msg});
		socket.emit('onMessage', json);
	}
})();