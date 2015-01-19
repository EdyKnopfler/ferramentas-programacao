<?php

require_once('../lib/funcoes.php');
require_once('../lib/tratar-post.php');
require_once('../lib/dao-geral.php');
require_once('config.php');

session_start();

$endereco = explode("/", $_SERVER["REQUEST_URI"]);
$encontrou = false;
$dirAtual  = getcwd() . "/";

do {
   $repetir = false;

   if ($endereco[$cont] == '')
      $endereco[$cont] = 'inicial';
   
   $procurar = $endereco[$cont];
   $pasta    = $dirAtual . "$procurar/";
   $arquivo  = $dirAtual . "$procurar.php";

   if ( file_exists($arquivo) ) {  // Existe o arquivo?
      $encontrou = true;
   }
   else if ( file_exists($pasta) ) {  // Existe a pasta?
      $cont++;
      $dirAtual = $pasta;
      
      if ( ! isset($endereco[$cont]) )  // A pasta pode ter sido o último item digitado
         $endereco[$cont] = 'inicial';
         
      $repetir = true;
   }
} while ($repetir);
   
if ($encontrou) {
   $modulo = $endereco[$cont];
   $params = array();
   $cont++;

   for ($i = $cont; $i <= count($endereco) - 1; $i++) {
      if ($endereco[$i] != "")
         $params[] = $endereco[$i];
   }

   require($arquivo);
}
else {
   $modulo = '404';
   require("404.php");
}

mysql_close($db);

?>
