<?php

require('verificar-login.php');

// Validação no servidor
extract($_POST);

if (trim($nome) == '') die('Nome!');
if (trim($login) == '') die('Login!');

$set = "
   nome = '$nome',
   login = '$login'
";

if ($id_usuario != '') {
   if ( isset($alterar_senha) ) {
      if (trim($senha_atual) == '') die('Senha atual!');
      
      validarSenhaNova();
   
      $dao->consultar('usuarios', 'senha', "id_usuario = $id_usuario");
      $u = mysql_fetch_assoc($dao->resultado);
      
      if ($u['senha'] != $senha_atual) {
         $_SESSION['msg_senha'] = 'Senha atual incorreta.';
         redirecionar("usuarios/form/$id_usuario");
         die();      
      }   
      
      $set .= ", senha = '$senha_nova'";   
   }
}   
else {
   validarSenhaNova();
   $set .= ", senha = '$senha_nova'";
}

// Executar o SQL
if ($id_usuario == '')
   $dao->insert('usuarios', $set);
else
   $dao->update('usuarios', $set, "id_usuario = $id_usuario");
   
redirecionar('usuarios/inicial');


function validarSenhaNova() {
   global $senha_nova, $conf_senha;
   
   if (trim($senha_nova) == '') die('Senha nova!');
   if (trim($conf_senha) == '') die('Confirme a senha!');
   if ($senha_nova != $conf_senha) die('Senhas não coincidem!');
}
?>
