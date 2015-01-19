<?php

require('verificar-login.php');

extract($_POST);

$arquivo = "../img/$modulo/$imagem";
$extensao = explode('.', $imagem);
$extensao = strtolower($extensao[count($extensao) - 1]);

if ($extensao == 'png')
   $origem = imagecreatefrompng($arquivo);
else
   $origem = imagecreatefromjpeg($arquivo);
   
$destino = ImageCreateTrueColor($w, $h);

imagecopyresampled(
   $destino, $origem,  // Imagens
   0, 0,               // x,y (destino)
   $x, $y,             // x,y (origem)
   $w, $h,             // larg, alt (destino)
   $w, $h              // larg, alt (origem)
);

if ($extensao == 'png')
   imagepng($destino, $arquivo);
else
   imagejpeg($destino, $arquivo, 100);

header('Location: ' . $url . $modulo);

?>
