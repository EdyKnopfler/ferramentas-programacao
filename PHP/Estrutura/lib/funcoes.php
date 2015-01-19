<?php

function redirecionar($onde) {
   global $url;
   
   ?>
      <script>
         window.location = '<?= $url . $onde ?>';
      </script>
   <?
}

function seoString($s) {
   $map = array(
       'á' => 'a',
       'à' => 'a',
       'ã' => 'a',
       'â' => 'a',
       'é' => 'e',
       'ê' => 'e',
       'í' => 'i',
       'ó' => 'o',
       'ô' => 'o',
       'õ' => 'o',
       'ú' => 'u',
       'ü' => 'u',
       'ç' => 'c',
       'Á' => 'A',
       'À' => 'A',
       'Ã' => 'A',
       'Â' => 'A',
       'É' => 'E',
       'Ê' => 'E',
       'Í' => 'I',
       'Ó' => 'O',
       'Ô' => 'O',
       'Õ' => 'O',
       'Ú' => 'U',
       'Ü' => 'U',
       'Ç' => 'C',
       ' ' => '-',
   );

   // Faz as trocas de caracteres (acentos e espaços)
   $s = strtr(trim($s), $map);
                           
   // Tira os outros caracteres
   $s = ereg_replace("[^a-zA-Z0-9_-]", "", $s);
   
   // Coloca em minúsculas
   return strtolower($s);
}

function dataHoraBR($dhMy) {
   if ($dhMy == '' or $dhMy == '0000-00-00 00:00:00')
      return '';
   
   $separa = explode(" ", $dhMy);
   $data   = explode("-", $separa[0]);
   $data   = "$data[2]/$data[1]/$data[0]";
   return  "$data às $separa[1]";
}

function dataBR($dMy) {
   if ($dMy == '' or $dMy == '0000-00-00')
      return '';
   
   $data = explode("-", $dMy);
   return "$data[2]/$data[1]/$data[0]";
}

function dataHoraMySQL($dhBR) {
   $separa = explode(" ", $dhBR);
   $data   = explode("/", $separa[0]);
   $data   = "$data[2]-$data[1]-$data[0]";
   return  "$data $separa[1]";
}

function dataMySQL($dBR) {
   $data  = explode("/", $dBR);
   return "$data[2]-$data[1]-$data[0]";
}

function alerta($msg) {
   ?>
      <script>
         alert("<?= $msg ?>");
      </script> 
   <?
}

function retornar($qtd) {
   ?>
      <script>
         history.go(<?= $qtd * -1 ?>);
      </script> 
   <?
}

function enviarEmail($nome, $de, $para, $assunto, $msg) {
   $headers  = "MIME-Version: 1.0" . "\n";
   $headers .= "Content-type:text/html;charset=iso-8859-1" . "\n";
   $headers .= "From: $nome <$de>" . "\n";
   mail($para, $assunto, $msg, $headers);
}

function enviarEmailAdm($nome, $de, $assunto, $msg) {
   global $dao;
   $dao->consultar('configuracoes', 'emails_contato', 'id_configuracao = 1');
   $emails = mysql_fetch_row($dao->resultado);
   $emails = $emails[0];
   enviarEmail($nome, $de, $emails, $assunto, $msg);
}

function indiceThumb($screenWidth, $pixelRatio, $breakpoints, $thumbs) {
   // Procurar o width CSS da imagem de acordo com o breakpoint
   unset($width);
      
   foreach ($breakpoints as $break => $imgWidth) {
      // Primeiro width é o padrão (mobile-first)
      if ( ! isset($width) or $screenWidth >= $break)
         $width = $imgWidth;
   }
   
   // Multiplicar pelo device pixel ratio e procurar o thumb adequado
   $width *= $pixelRatio;
   unset($thumb);
   
   foreach($thumbs as $t=>$thumbWidth) {
      if ($thumbWidth >= $width) {
         $thumb = $t;
         break;
      }
   }
   
   return $thumb;
}

?>
