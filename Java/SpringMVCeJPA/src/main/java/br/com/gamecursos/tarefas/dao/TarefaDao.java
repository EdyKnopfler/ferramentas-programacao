package br.com.gamecursos.tarefas.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import br.com.gamecursos.tarefas.modelo.Tarefa;

@Repository
public class TarefaDao {
	
	@PersistenceContext
	public EntityManager manager;
	
	public List<Tarefa> lista() {
		return manager.createQuery("select t from Tarefa t").getResultList();
	}

}
