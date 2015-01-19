package br.com.gamecursos.tarefas.modelo;

import javax.persistence.*;
import java.util.Calendar;

@Entity
public class Tarefa {
	
	@Id @GeneratedValue
	public Long id;
	
	public String descricao;
	
	public boolean finalizado;
	
	@Temporal(TemporalType.DATE)
	public Calendar dataFinalizacao;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public boolean isFinalizado() {
		return finalizado;
	}

	public void setFinalizado(boolean finalizado) {
		this.finalizado = finalizado;
	}

	public Calendar getDataFinalizacao() {
		return dataFinalizacao;
	}

	public void setDataFinalizacao(Calendar dataFinalizacao) {
		this.dataFinalizacao = dataFinalizacao;
	}

}
