<?php

require('verificar-login.php');

$dao->delete('usuarios', "id_usuario = $_POST[id]");

?>
