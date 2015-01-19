<?php

if ( ! isset($_SESSION['admin']) ) {
   redirecionar('logar');
   die();
}

?>
