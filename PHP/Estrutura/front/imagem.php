<?php

// Solicitação de imagem responsiva

header('Content-type: image/jpeg');

// min-width => largura da imagem
$resolucoes = array();
$resolucoes['produtos'] = array(0 => 100, 360 => 150, 480 => 200, 760 => 300, 960 => 400);

$usarResolucoes = $resolucoes[ $params[0] ];
$breakpoints = array_keys($usarResolucoes);
rsort($breakpoints);
$usar = $usarResolucoes[ $breakpoints[0] ];

foreach ($breakpoints as $b) {
   if ($_COOKIE['resolution'] >= $b) {
      $usar = $usarResolucoes[$b];
      break;
   }
}

// Compressive Images (duplicada com qualidade baixa)
$usar *= $_COOKIE['pixel_ratio'] * 2;  

$arquivo = "img/$params[0]/$params[1]";
$extensao = explode('.', $params[1]);
$extensao = strtolower($extensao[count($extensao) - 1]);

$cacheDir = "img/$params[0]/cache/$usar";
$cacheArq = $cacheDir . '/' . str_ireplace('.png', '.jpg', $params[1]);

// Tem em cache
$temCache = false;
if ( file_exists($cacheArq) ) {
   if ( filemtime($cacheArq) > filemtime($arquivo) )
      $temCache = true;
}

if ($temCache) {
   $imagem = imagecreatefromjpeg($cacheArq);
   imagejpeg($imagem, null, 30);
}
else {
   if ($extensao == 'png')
      $origem = imagecreatefrompng($arquivo);
   else
      $origem = imagecreatefromjpeg($arquivo);
      
   $wOrigem = imagesx($origem);
   $hOrigem = imagesy($origem);

   $razao = $wOrigem / $hOrigem;
   $wDestino = $usar;
   $hDestino = $usar / $razao;

   $destino = ImageCreateTrueColor($wDestino, $hDestino);

   imagecopyresampled(
      $destino, $origem,    // Imagens
      0, 0,                 // x,y (destino)
      0, 0,                 // x,y (origem)
      $wDestino, $hDestino, // larg, alt (destino)
      $wOrigem, $hOrigem    // larg, alt (origem)
   );

   // Fazer cache
   if ( ! is_dir($cacheDir) ) 
      mkdir($cacheDir);
      
   imagejpeg($destino, $cacheArq, 30);
   
   // Ennviar a imagem
   imagejpeg($destino, null, 30);
}

?>
