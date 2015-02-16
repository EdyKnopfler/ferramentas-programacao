// Configurações
var express = require('express');
var session = require('express-session');
var bodyParser = require('body-parser');  // Requerido para tratar POST! :(
var app = express();

app.set('views', __dirname + '/views');
app.set('view engine', 'ejs');

app.use(session({secret: 'kakakakaka'}));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));

// Middleware (filtro)
app.use(function(req, res, next) {
    if (req.url == '/login') {
        next();
    }
    else {
        var sess = req.session;

        if (!sess.login)
            res.redirect('/login');
        else
            next();
    }
});

// Rotas
app.get('/', function(req, res) {
    res.render('index');
});

app.route('/login')
   .get(function(req, res) {
       res.render('login', {mensagem: ''});
    })
   .post(function(req, res) {
       if (req.body.usuario != 'admin' && req.body.senha != '123') {
           res.render('login', {mensagem: 'Dados de login inválidos.'});
           return;
       }
    
       var sess = req.session;
       sess.login = {
           usuario: req.body.usuario,
           senha: req.body.senha
       };
       res.redirect('/');
    });

app.get('/sair', function(req, res) {
    req.session.login = null;
    res.redirect('/login');
});

// Começa o jogo!
app.listen(3000);