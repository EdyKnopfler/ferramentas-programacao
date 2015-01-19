<?php

require('verificar-login.php');

// Validação no servidor
extract($_POST);

if (trim($nome) == '') die('Nome!');
if (trim($preco) == '') die('Preço!');

$preco = str_replace('.', '', $preco);
$preco = str_replace(',', '.', $preco);
if ( ! is_numeric($preco) ) die('Preço inválido');

if (trim($descricao) == '') die('Descrição!');
if ($id_produto == '' and $_FILES['imagem']['size'] == 0) die('Imagem!');

// SET do SQL
$set = "
   nome = '$nome',
   preco = $preco,
   descricao = '$descricao'
";

// Upload da imagem
if ( $_FILES['imagem']['size'] > 0 ) {
   $extensao = explode('.', $_FILES['imagem']['name']);
   $extensao = $extensao[ count($extensao) - 1 ];

   
   $nomeArquivo = seoString($nome) . ".$extensao";
   $caminho = "../img/produtos/$nomeArquivo";
   
   if ( file_exists($caminho) )
      unlink($caminho);
   
   move_uploaded_file($_FILES['imagem']['tmp_name'], $caminho);
   $set .= ", imagem = '$nomeArquivo'";
   
   header('Location: ' . $url . "crop/form/produtos/$nomeArquivo/1");  // 1 = ratio
}
else
   header('Location: ' . $url . 'produtos');

// Executar o SQL
if ($id_produto == '')
   $dao->insert('produtos', $set);
else
   $dao->update('produtos', $set, "id_produto = $id_produto");

?>
