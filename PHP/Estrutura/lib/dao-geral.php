<?php

class DaoGeral {

   public $conexao;
   public $sql;
   public $resultado;
   public $idGerado;

   public function __construct($c) {
      $this->conexao = $c;
   }

   public function select($tabela, $campos, $complemento) {
      $this->sql = "SELECT SQL_CALC_FOUND_ROWS $campos FROM $tabela $complemento";
      $this->resultado = mysql_query($this->sql, $this->conexao);
      $this->verificarErro();
      return $this->resultado;
   }

   public function insert($tabela, $camposValores) {
      $this->sql = "INSERT INTO $tabela SET $camposValores";
      $this->resultado = mysql_query($this->sql, $this->conexao);
      $this->verificarErro();
      $this->idGerado = mysql_insert_id();
      return $this->resultado;
   }

   public function delete($tabela, $condicao) {
      $this->sql = "DELETE FROM $tabela WHERE $condicao";
      $this->resultado = mysql_query($this->sql, $this->conexao);
      $this->verificarErro();
      return $this->resultado;
   }

   public function update($tab, $camposValores, $condicao) {
      $this->sql = "UPDATE $tab SET $camposValores WHERE $condicao";
      $this->resultado = mysql_query($this->sql, $this->conexao);
      $this->verificarErro();
      return $this->resultado;
   }

   public function consultar($tabela, $campos = "*", $condicao = "", $ordenacao = "",
                             $quant = null, $pagina = 1) {

      if ($condicao != "")
         $condicao = "WHERE $condicao";

      if ($ordenacao != "")
         $ordenacao = "ORDER BY $ordenacao";

      if ($quant != null) {
         $inicio = ($pagina - 1) * $quant;
         $limite = "LIMIT $inicio, $quant";
      }
      else
         $limite = "";

      return $this->select($tabela, $campos, "$condicao $ordenacao $limite");
   }
   
   public function linhasTotais() {
      $consulta = mysql_query("SELECT FOUND_ROWS()", $this->conexao);
      $reg      = mysql_fetch_row($consulta);
      return $reg[0];
   }

   private function verificarErro() {
	   $erro = mysql_error($this->conexao);

	   if ($erro != "") {
	      $msg = "<br /><br /><b>ERRO: </b> $erro";

		  if (isset($this->sql))
		     $msg .= "<br /><br /><b>SQL:</b> $this->sql";

		  die($msg);
	   }
   }

}

?>
