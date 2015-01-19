<?php

require('verificar-login.php');
require('cabecalho.php');

$pagina = isset($params[0])  ?  $params[0]  :  1;
$quantPorPag = 20;
$consulta = $dao->consultar('produtos', '*', '', 'nome', $quantPorPag, $pagina);

?>


<script>
   $(function() {
      $('img.excluir').click(function() {
         if ( ! confirm('Confirma a exclusão?') )
            return;
         
         var id = $(this).attr('data-id');
         
         $.post(
            '<?=$url?>produtos/excluir',
            {id: id},
            function(resposta) {
               if ( resposta.trim() == '')
                  $('tr#produto_' + id).remove();
               else
                  alert(resposta);
            }
         );
      });
   });
</script>


<h2>Produtos</h2>

<p>
   <a href="<?=$url?>produtos/form"><img src="<?=$url?>img/incluir.png">Cadastrar novo</a>
</p>

<table class="listagem">
   <thead>
      <tr>
         <th>Nome</th>
         <th>Preço</th>
         <th>&nbsp;</th>
      </tr>
   </thead>
   <tbody>
      <? while ($p = mysql_fetch_assoc($consulta)) { ?>
      
         <tr id="produto_<?=$p['id_produto']?>">
            <td class="produto_nome"><?=$p['nome']?></td>
            <td class="produto_preco"><?=number_format($p['preco'], 2, ',', '.')?></td>
            <td>
               <a href="<?=$url?>produtos/form/<?=$p['id_produto']?>"><img src="<?=$url?>img/alterar.png"></a>
               <img class="excluir" src="<?=$url?>img/excluir.png" data-id="<?=$p['id_produto']?>">
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
      <a href="<?=$url?>produtos/inicial/<?=($pagina - 1)?>">&lt; Anterior</a>
   <? } ?>
   
      
   <? if ($pagina > 1 and $pagina < $totalPags) { ?> | <? } ?>   
      
   
   <? if ($pagina < $totalPags) { ?>
      <a href="<?=$url?>produtos/inicial/<?=($pagina + 1)?>">Próxima &gt;</a>
   <? } ?>
</p>

<? 

require('rodape.php'); 

?>
