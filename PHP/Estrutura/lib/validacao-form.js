/**
  regras: 
  {
     campo1: {tipo: 'tipo', requerido: true, mensagem: 'xxx'},
     campo2: {tipo: 'tipo', requerido: false},
     // ...
  }
  
  tipos: texto, inteiro, decimal, data, hora, email, senha
*/
function validar(regras) {
   for (var campo in regras) {
      var input = $('#' + campo);
      var valor = $.trim(input.val());
      
      if (regras[campo].requerido) {
         if (valor == '') {
            notifica(input, regras[campo].mensagem);
            return false;
         }
      }
      else if (valor == '')
         continue;  // Próximo campo
      
      if (regras[campo].tipo == 'texto') {
         // Nada a fazer, simplesmente pode ser requerido ou não
      }
      else if (regras[campo].tipo == 'inteiro') {
         var ok = /^-?[0-9]+$/.test(valor);
         if ( ! ok ) {
            notifica(input, 'Infome um valor inteiro válido.');
            return false;
         }
      }
      else if (regras[campo].tipo == 'decimal') {
         var ok = /^-?[0-9]+,[0-9]+$/.test(valor) || /^-?[0-9]+$/.test(valor);
         if ( ! ok ) {
            notifica(input, 'Infome um valor decimal válido.');
            return false;
         }
      }
      else if (regras[campo].tipo == 'data') {
         var ok = dataValida(valor);
         if ( ! ok ) {
            notifica(input, 'Infome uma data válida.');
            return false;
         }
      }
      else if (regras[campo].tipo == 'hora') {
         var ok = horaValida(valor);
         if ( ! ok ) {
            notifica(input, 'Infome uma hora válida.');
            return false;
         }         
      }
      else if (regras[campo].tipo == 'email') {
         var ok = validarEmail(valor)
         if ( ! ok ) {
            notifica(input, 'Infome um e-mail válido.');
            return false;
         }         
      }
      else if (regras[campo].tipo == 'senha') {
         var confSenha = $.trim($('#' + regras[campo].confirmacao).val());
         if (valor != confSenha) {
            notifica(input, 'A senha e sua confirmação não coincidem.');
            return false;
         }         
      }
   }
   
   return true;
}

function notifica(input, mensagem) {
   input.focus();
   alert(mensagem);
}

function dataValida(data) {
   var d = data.split('/');
   
   var dia = parseInt( stripLeftZeros(d[0]) );
   var mes = parseInt( stripLeftZeros(d[1]) );
   var ano = parseInt( stripLeftZeros(d[2]) );
   
   var bissexto   = ( (ano % 4 == 0) || (ano % 100 == 0) || (ano % 400 == 0) );
   var diasFev    = ( bissexto  ?  29  :  28 );
   var limiteDias = [0, 31, diasFev, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
   
   if ( mes < 1 || mes > 12 )
      return false;
   
   if ( dia < 1 || dia > limiteDias[mes] )
      return false;
      
   return true;
}

function horaValida(hora) {
   var h = hora.split(':');
   
   var hor = parseInt( stripLeftZeros(h[0]) );
   var min = parseInt( stripLeftZeros(h[1]) );
   
   if ( hor < 0 || hor > 23 )
      return false;
   
   if ( min < 0 || min > 59 )
      return false;
   
   return true;
}

function validarEmail(strEmail) {
   var arroba = strEmail.indexOf("@");
   var ponto  = strEmail.lastIndexOf(".");

   if (strEmail == "" || arroba < 1 || ponto < arroba + 2 || ponto == strEmail.length - 1)
      return false;
   else
      return true;
}

function stripLeftZeros(sStr){
   for (var i=0;i<sStr.length;i++)
      if (sStr.charAt(i)!='0')
         return sStr.substring(i);
   
   return sStr;
}