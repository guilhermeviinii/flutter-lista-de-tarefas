import 'package:tarefas/models/tarefa.model.dart';

class TarefaRepo {

  // ignore: deprecated_member_use
  static List<Tarefa> tarefas = List<Tarefa>();

  TarefaRepo(){
    if(tarefas.isEmpty){
      tarefas.add(Tarefa(id: '1', texto: "Lavar o carro", finalizada: false));
      tarefas.add(Tarefa(id: '2', texto: "Estudar", finalizada: true));
      tarefas.add(Tarefa(id: '3', texto: "Assistir filme", finalizada: true));
    }
  }

  void create(Tarefa tarefa){
    tarefas.add(tarefa);
  }

  List<Tarefa> read(){
    return tarefas;
  }

  void delete(String id){
    final tarefa = tarefas.singleWhere((t) => t.texto == id);
    tarefas.remove(tarefa);
  }
  void update(Tarefa newTarefa, Tarefa oldTarefa){
    final tarefa = tarefas.singleWhere((t) => t.texto == oldTarefa.texto);
    tarefa.texto = newTarefa.texto;
  }
}