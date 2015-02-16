// Config
var express = require('express');
var app = express();

app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');
app.use(express.static(__dirname + '/public'));

// Rotas
var index = require('./controllers/index');
var usuarios = require('./controllers/usuarios');

app.get('/', index.index);
app.get('/usuarios', usuarios.index);
app.get('/usuarios/novo', usuarios.novo);
app.get('/usuarios/editar/:id', usuarios.editar);

// Começou!
app.listen(3000, function() {
    console.log('Rodando!');
});