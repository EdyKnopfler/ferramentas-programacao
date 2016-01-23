// Paypal -------------------------------------------------------

var paypal = require('paypal-rest-sdk');

paypal.configure({
   "host" : "api.sandbox.paypal.com",           
   "client_id" : "blá blá blá",
   "client_secret" : "blé blé blé"
});


// Express ------------------------------------------------------

var express = require('express');
var app = express();

app.set('port', 3000);
app.use(express.static('./public'));

app.get('/pagar', pagamento);

app.listen(3000, function() {
    console.log('Rodando!');
});

// Controller do pagamento --------------------------------------

function pagamento(req, res) {
   // Criando o pagamento
   var payment = {
      "intent": "sale",
      "payer": {
         "payment_method": "paypal"
      },
      "redirect_urls": {
         "return_url": "http://localhost:3000/pago.html",
         "cancel_url": "http://localhost:3000/"
      },
      "transactions": [{
         "amount": {
            "total": "5.00",
            "currency": "BRL"
         },
         "description": "É cinco reáu"
      }]
   };
   
   // Pagando
   paypal.payment.create(payment, function (error, payment) {
      if (error) {
         console.log(error);
         return;
      }
      
      console.log('paymentId = ' + payment.id);

      var redirectUrl;
      for(var i=0; i < payment.links.length; i++) {
         var link = payment.links[i];
         if (link.method === 'REDIRECT') {
            redirectUrl = link.href;
         }
      }
      res.redirect(redirectUrl);
   });
}
