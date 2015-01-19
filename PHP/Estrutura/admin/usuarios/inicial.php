<?php

require('verificar-login.php');
require('cabecalho.php');

$pagina = isset($params[0])  ?  $params[0]  :  1;
$quantPorPag = 20;
$consulta = $dao->consultar('usuarios', '*', '', 'nome', $quantPorPag, $pagina);

?>


<script>
   $(function() {
      $('img.excluir').click(function() {
         if ( ! confirm('Confirma a exclusão?') )
            return;
         
         var id = $(this).attr('data-id');
         
         $.post(
            '<?=$url?>usuarios/excluir',
            {id: id},
            function(resposta) {
               if ( resposta.trim() == '')
                  $('tr#usuario_' + id).remove();
               else
                  alert(resposta);
            }
         );
      });
   });
</script>


<h2>Usuários</h2>

<p>
   <a href="<?=$url?>usuarios/form"><img src="<?=$url?>img/incluir.png">Cadastrar novo</a>
</p>

<table class="listagem">
   <thead>
      <tr>
         <th>Nome</th>
         <th>Login</th>
         <th>&nbsp;</th>
      </tr>
   </thead>
   <tbody>
      <? while ($u = mysql_fetch_assoc($consulta)) { ?>
      
         <tr id="usuario_<?=$u['id_usuario']?>">
            <td class="usuario_nome"><?=$u['nome']?></td>
            <td class="usuario_login"><?=$u['login']?></td>
            <td>
               <a href="<?=$url?>usuarios/form/<?=$u['id_usuario']?>"><img src="<?=$url?>img/alterar.png"></a>
               <img class="excluir" src="<?=$url?>img/excluir.png" data-id="<?=$u['id_usuario']?>">
            </td>
         </tr>
      
      <? } ?>
   </tbody>
</table>

<p class="paginacao">
   <?php
      $totalPags = $dao->linhasTotais() / $quantPorPag;
   ?>
   
   <? if ($pagina > 1) { ?>
      <a href="<?=$url?>usuarios/inicial/<?=($pagina - 1)?>">&lt; Anterior</a>
   <? } ?>
   
      
   <? if ($pagina > 1 and $pagina < $totalPags) { ?> | <? } ?>   
      
   
   <? if ($pagina < $totalPags) { ?>
      <a href="<?=$url?>usuarios/inicial/<?=($pagina + 1)?>">Próxima &gt;</a>
   <? } ?>
</p>

<? 

require('rodape.php'); 

?>
