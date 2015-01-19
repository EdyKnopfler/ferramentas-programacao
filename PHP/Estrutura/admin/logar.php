<?php

$msgLogin = '';

if ( isset($_POST['login']) ) {
   extract($_POST);
   $dao->consultar('usuarios', '*', "login = '$login' AND senha = '$senha'");
   
   if ($usuario = mysql_fetch_assoc($dao->resultado)) {
      $_SESSION['admin'] = $usuario;
      redirecionar('');  // Inicial
      die();
   }
   else
      $msgLogin = 'Dados de login inválidos.';
}

?>



<!DOCTYPE html>
<html>

<head>
   <meta charset="UTF-8">
   <title>EAD Games - Login do administrador</title>
</head>

<body>

   <h1>EAD Games - Área de administração</h1>
   
   <h2>Login do administrador</h2>

   <? if ($msgLogin != '') { ?>

      <p class="mensagem"><?=$msgLogin?></p>

   <? } ?>

   <form method="post">
      <p>
         Login: <br>
         <input type="text" name="login" maxlength="30">
      </p>
      <p>
         Senha: <br>
         <input type="password" name="senha" maxlength="30">
      </p>
      <p>
         <input type="submit" value="Entrar">
      </p>

   </form>

</body>

</html>
