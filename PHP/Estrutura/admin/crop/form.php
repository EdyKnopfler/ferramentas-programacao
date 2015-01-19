<?php

require('verificar-login.php');
require('cabecalho.php');

?>

<script src="<?=$urlSite?>lib/jcrop/jquery.Jcrop.min.js"></script>
<link rel="stylesheet" href="<?=$urlSite?>lib/jcrop/jquery.Jcrop.min.css">

<script>
  $(function(){

    $('#cropbox').Jcrop({
      aspectRatio: <?=$params[2]?>,
      onSelect: updateCoords
    });

  });

  function updateCoords(c)
  {
    $('#x').val(c.x);
    $('#y').val(c.y);
    $('#w').val(c.w);
    $('#h').val(c.h);
  };

  function checkCoords()
  {
    if (parseInt($('#w').val())) return true;
    alert('Favor selecionar a área de recorte.');
    return false;
  };

</script>

<h1>Enquadramento de imagem</h1>

<!-- This is the image we're attaching Jcrop to -->
<img src="<?=$urlSite?>img/<?=$params[0]?>/<?=$params[1]?>" id="cropbox">

<!-- This is the form that our event handler fills -->
<form action="<?=$url?>crop/salvar" method="post" onsubmit="return checkCoords();">
   <input type="hidden" name="modulo" value="<?=$params[0]?>">
   <input type="hidden" name="imagem" value="<?=$params[1]?>">
	<input type="hidden" id="x" name="x">
	<input type="hidden" id="y" name="y">
	<input type="hidden" id="w" name="w">
	<input type="hidden" id="h" name="h">
	<input type="submit" value="Enquadrar">
</form>



<?

require('rodape.php');

?>
