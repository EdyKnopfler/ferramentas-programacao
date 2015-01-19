<?php

$dao->consultar('produtos', '*', '', 'nome');

require('front/include/cabecalho.php');

while ($p = mysql_fetch_assoc($dao->resultado)) { 
 ?>

   <article class="produto">
      <h2><?=$p['nome']?></h2>

      <img src="<?=$url?>imagem/produtos/<?=$p['imagem']?>">
      
      <p class="preco"><?=number_format($p['preco'], 2, ',', '.')?></p>
      
      <?=$p['descricao']?>
      
      <br clear="all">
   </article>

 <?
}

require('front/include/rodape.php');

?>
