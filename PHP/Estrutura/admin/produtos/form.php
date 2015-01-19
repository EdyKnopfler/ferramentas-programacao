<?php

require('verificar-login.php');
require('cabecalho.php');

$id_produto = '';
$nome = '';
$preco = '';
$descricao = '';
$imagem = '';

if ( isset($params[0]) ) {
   $dao->consultar('produtos', '*', "id_produto = $params[0]");

   if ($p = mysql_fetch_assoc($dao->resultado)) {
      extract($p);
      $preco = number_format($preco, 2, ',', '');
   }
}
   
?>


<script src="<?=$urlSite?>lib/validacao-form.js"></script>
<script>
   $(function() {
      $('form').submit(function() {
         return validar({
            nome: {tipo: 'texto', requerido: true, mensagem: 'Nome!'},
            preco: {tipo: 'decimal', requerido: true, mensagem: 'Preço!'},
            descricao: {tipo: 'tipo', requerido: true, mensagem: 'Descrição!'},
            imagem: {tipo: 'texto', requerido: <?=($imagem == ''  ?  'true'  :  'false')?>, mensagem: 'Imagem!'}
         });
      });
   });
</script>


<form method="post" enctype="multipart/form-data" action="<?=$url?>produtos/salvar">
   <input type="hidden" name="id_produto" value="<?=$id_produto?>">
   
   <p>
      Nome: <br>
      <input type="text" name="nome" id="nome" maxlength="100" value="<?=$nome?>">
   </p>

   <p>
      Preço: <br>
      <input type="text" name="preco" id="preco" value="<?=$preco?>">
   </p>

   <p>
      Descrição: <br>
      <textarea name="descricao" id="descricao"><?=$descricao?></textarea>
   </p>

   <p>
      Imagem: <br>
      <input type="file" name="imagem" id="imagem">
   </p>
   <p>
      <input type="submit" value="Salvar">
   </p>
</form>


<? 

require('rodape.php'); 

?>
