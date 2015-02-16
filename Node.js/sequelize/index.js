var Sequelize = require('sequelize');
var sequelize = 
   new Sequelize('Estudo1', 'postgres', 'jethrotull', {
      dialect: "postgres", // or 'sqlite', 'mysql', 'mariadb'
      port:    5432, // or 5432 (for postgres)
   });
 
sequelize
   .authenticate()
   .complete(function(err) {
      if (!!err) {
         console.log('Erro ao conectar ao PostgreSQL:', err);
      } else {
         console.log('PostgreSQL conectado.');
         entidade();
         sincronizar();
      }
   });


var Animal;

function entidade() {
   Animal = sequelize.define(
      'Animal', 
      {
         nome: Sequelize.STRING,
         especie: Sequelize.STRING,
         raca: Sequelize.STRING,
         idade: Sequelize.INTEGER
      }, 
      {
         tableName: 'animais',
         updatedAt: 'ultima_atualizacao',
         createdAt: 'data_insercao'
      }
   );
}

function sincronizar() {
   sequelize
      .sync()
      .complete(function(err) {
         if (!!err) {
            console.log('Falha ao sincronizar schema:', err);
         } else {
            console.log('Schema sincronizado.');
            persistir();
         }
      });
}

function persistir() {
   var animal = Animal.build({
      nome: 'Scania',
      especie: 'Gato',
      raca: 'Rasga-saco',
      idade: 2
   });
 
   animal
      .save()
      .complete(function(err, result) {
         if (!!err) {
            console.log('Erro ao persistir:', err);
         } else {
            console.log('Animal persistido com sucesso! ID = ' + result.id);
            consultar(result.id);
         }
      });
}

function consultar(id) {
   Animal
      // .find(id) :D
      .find({ where: { id: id } })
      .complete(function(err, kania) {
         if (!!err) {
            console.log('Erro ao consultar:', err);
         } else if (!kania) {
            console.log('Animal não encontrado.');
         } else {
            console.log('ID:      ' + kania.id);
            console.log('Nome:    ' + kania.nome);
            console.log('Espécie: ' + kania.especie);
            console.log('Raça:    ' + kania.raca);
            console.log('Idade:   ' + kania.idade);
         }
      });
}
