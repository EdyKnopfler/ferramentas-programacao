<?php

$urlSite = 'http://localhost/testes/';
$url = 'http://localhost/testes/admin/';
$cont = 3;  // Posição na URL

date_default_timezone_set('America/Sao_Paulo');

$db = mysql_connect('localhost', 'root', 'jethrotull') or die(mysql_error());
mysql_select_db('testes', $db) or die(mysql_error());
mysql_set_charset('utf8');

$dao = new DaoGeral($db);

?>
