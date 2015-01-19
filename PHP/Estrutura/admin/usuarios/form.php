<?php

require('verificar-login.php');
require('cabecalho.php');

$id_usuario = '';
$nome = '';
$login = '';

if ( isset($params[0]) ) {
   $dao->consultar('usuarios', '*', "id_usuario = $params[0]");

   if ($u = mysql_fetch_assoc($dao->resultado))
      extract($u);
}
   
?>


<script src="<?=$urlSite?>lib/validacao-form.js"></script>
<script>
   $(function() {
      $('form').submit(function() {
         var regras = {
            nome: {tipo: 'texto', requerido: true, mensagem: 'Nome!'},
            login: {tipo: 'texto', requerido: true, mensagem: 'Login!'},
         };
         
         
         <? if ($id_usuario != '') { ?>
         
            if ( $('#alterar_senha').is(':checked') ) {
               regras.senha_atual = {tipo: 'texto', requerido: true, mensagem: 'Senha atual!'};
               regras.senha_nova = {tipo: 'senha', requerido: true, mensagem: 'Senha!', 
                  confirmacao: 'conf_senha'};         
            }
         
         <? } else { ?>
         
               regras.senha_nova = {tipo: 'senha', requerido: true, mensagem: 'Senha!', 
                  confirmacao: 'conf_senha'};         
         
         <? } ?>
         
         return validar(regras);
      });
   });
</script>

<? 
   if ( isset($_SESSION['msg_senha']) ) {
      ?> <p class="mensagem"><?=$_SESSION['msg_senha']?></p> <?   
      unset($_SESSION['msg_senha']);
   }
?>


<form method="post" action="<?=$url?>usuarios/salvar">
   <input type="hidden" name="id_usuario" value="<?=$id_usuario?>">
   
   <p>
      Nome: <br>
      <input type="text" name="nome" id="nome" maxlength="100" value="<?=$nome?>">
   </p>

   <p>
      Login: <br>
      <input type="text" name="login" id="login" maxlength="30" value="<?=$login?>">
   </p>

   <? if ($id_usuario != '') { ?>
   
      <fieldset>
         <legend>
            <input type="checkbox" id="alterar_senha" name="alterar_senha">
            <label for="alterar_senha">Alterar senha</label>
         </legend>
            
         <p>
            Senha atual: <br>
            <input type="password" name="senha_atual" id="senha_atual" maxlength="30">
         </p>

         <p>
            Nova senha: <br>
            <input type="password" name="senha_nova" id="senha_nova" maxlength="30">
         </p>

         <p>
            Confirme a senha: <br>
            <input type="password" name="conf_senha" id="conf_senha" maxlength="30">
         </p>
      </fieldset>
        
   <? } else { ?>
      
         <p>
            Nova senha: <br>
            <input type="password" name="senha_nova" id="senha_nova" maxlength="30">
         </p>

         <p>
            Confirme a senha: <br>
            <input type="password" name="conf_senha" id="conf_senha" maxlength="30">
         </p>
      
   <? } ?>

   <p>
      <input type="submit" value="Salvar">
   </p>
</form>


<? 

require('rodape.php'); 

?>
