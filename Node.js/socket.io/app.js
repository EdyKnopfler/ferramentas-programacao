// Config
var express = require('express');
var http = require('http');
var app = express();
var server = http.createServer(app);
var io = require('socket.io').listen(server);

app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
app.use(express.static(__dirname + '/public'));

// Rotas
var inicial = require('./controllers/inicial');

app.get('/', inicial.index);

// Servidores
server.listen(3000, function() {
    console.log('Rodando!');
});

io.sockets.on('connection', function(socket) {
   console.log('Cliente conectado.');

   var dataPusher = setInterval(function() {
      socket.volatile.emit('data', Math.random() * 100);
   }, 1000);

   socket.on('disconnect', function() {
      console.log('Cliente desconectado.');
   });
});
