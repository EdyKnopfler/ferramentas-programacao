<?php

require('verificar-login.php');

// Excluir a imagem
$dao->consultar('produtos', 'imagem', "id_produto = $_POST[id]");
$prod = mysql_fetch_assoc($dao->resultado);

if ( file_exists("../img/produtos/$prod[imagem]") )
   unlink("../img/produtos/$prod[imagem]");

$dao->delete('produtos', "id_produto = $_POST[id]");

?>
