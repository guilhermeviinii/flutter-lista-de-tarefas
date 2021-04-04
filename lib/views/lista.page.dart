import 'package:flutter/material.dart';
import 'package:tarefas/models/tarefa.model.dart';
import 'package:tarefas/repositories/tarefa.repository.dart';
import 'package:tarefas/views/nova.page.dart';

class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  final repo = TarefaRepo();

  List<Tarefa> tarefas;

  @override
  initState() {
    super.initState();
    this.tarefas = repo.read();
  }

  Future handleAddTask(BuildContext context) async {
    var result = await Navigator.of(context).pushNamed('/nova');
    if (result == true) {
      setState(() => {this.tarefas = repo.read()});
    }
  }

  Future<bool> confirmarExclusao(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return AlertDialog(
            title: Text("Você tem certeza que deseja exlcuir?"),
            actions: [
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text("NÃO")),
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text("SIM")),
            ],
          );
        });
  }

  bool canEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de tarefas'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                setState(() => canEdit = !canEdit);
              })
        ],
      ),
      body: ListView.builder(
        itemCount: repo.read().length,
        itemBuilder: (_, indice) {
          var tarefa = this.tarefas[indice];
          return Dismissible(
            key: Key(tarefa.texto),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (direction) => {
              print(direction == DismissDirection.endToStart),
              print(direction == DismissDirection.startToEnd),
              repo.delete(tarefa.texto),
              setState(() => this.tarefas = repo.read())
            },
            confirmDismiss: (_) => confirmarExclusao(context),
            child: CheckboxListTile(
              title: Row(
                children: [
                  canEdit
                      ? IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () async {
                            var result = await Navigator.of(context)
                                .pushNamed('/edita', arguments: tarefa);
                            if (result) {
                              setState(() => this.tarefas = repo.read());
                            }
                          })
                      : Container(),
                  Text(repo.read()[indice].texto),
                ],
              ),
              value: this.tarefas[indice].finalizada,
              onChanged: (value) {
                setState(() => tarefa.finalizada = value);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => handleAddTask(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
