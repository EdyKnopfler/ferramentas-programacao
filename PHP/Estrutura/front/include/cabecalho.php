<!DOCTYPE html>
<html>

<head>

   <!-- Para imagens responsivas -->
   <script>
      document.cookie = 'resolution=' + Math.max(screen.width, screen.height);
      document.cookie = 'pixel_ratio=' + ("devicePixelRatio" in window  ?  devicePixelRatio  :  "1");
   </script>
   
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <title>EAD Games <?= isset($tituloPagina)  ?  "- $tituloPagina"  :  '' ?></title>
   <link rel="stylesheet" href="<?=$url?>estilo.css">   

</head>

<body>

   <h1>EAD Games</h1>
