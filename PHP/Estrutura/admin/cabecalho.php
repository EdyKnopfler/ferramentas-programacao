<!DOCTYPE html>
<html>

<head>
   <meta charset="UTF-8">
   <title>EAD Games - Área de administração</title>
   <script src="<?=$urlSite?>lib/jquery-2.1.1.min.js"></script>
</head>

<body>
   <h1>EAD Games - Área de administração</h1>
   
   <p id="bem_vindo">Bem-vindo, <b><?=explode(' ', $_SESSION['admin']['nome'])[0]?></b>!</p>

   <nav id="menu">
      <a href="<?=$url?>produtos">Produtos</a>
      <a href="<?=$url?>usuarios">Usuários</a>
      <a href="<?=$url?>sair">Sair</a>
   </nav>
