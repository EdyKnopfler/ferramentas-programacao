<?php

function tratar($variavel) {
   // Verificar se as aspas duplas já estão tratadas pelo Magic Quotes
   $variavel_filtrada = get_magic_quotes_gpc() ? stripslashes($variavel) : $variavel;
   $variavel_filtrada = str_replace("'", "''", $variavel_filtrada);

   // Filtrar comandos SQL
   /*
   $variavel_filtrada = preg_replace("/(from|select|insert|update|delete|where|drop table|show tables|#|\*|--|\\\\)/i", "", $variavel_filtrada);
   */

   // Filtrar scripts
   $variavel_filtrada = str_ireplace("<script", "&lt;script", $variavel_filtrada);
   $variavel_filtrada = str_ireplace("</script", "&lt;/script", $variavel_filtrada);

   return $variavel_filtrada;
}

function tratarRecursivo(&$variavel) {
   if (is_array($variavel)) {
      foreach ($variavel as &$v)
         tratarRecursivo($v);
   }
   else
      $variavel = tratar($variavel);
}

tratarRecursivo($_REQUEST);
tratarRecursivo($_GET);
tratarRecursivo($_POST);

?>
