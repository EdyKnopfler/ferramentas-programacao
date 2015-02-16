exports.index = function(req, res) {
    res.render('usuarios/index', {titulo: "Fuc"});
}

exports.novo = function(req, res) {
    res.render('usuarios/form', {titulo: "Novo usuário", login: '', senha: '', id: 0});
}

exports.editar = function(req, res) {
    // Dados viriam do BD
    res.render('usuarios/form', {titulo: "Editar usuário", login: 'teste', senha: 'teste', id: req.params.id});
}