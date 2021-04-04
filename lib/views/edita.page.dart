import 'package:flutter/material.dart';
import 'package:tarefas/models/tarefa.model.dart';
import 'package:tarefas/repositories/tarefa.repository.dart';

class EditaPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _tarefa = Tarefa();
  final _repository = TarefaRepo();

  void submitForm(BuildContext context, Tarefa tarefa) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _repository.update(_tarefa, tarefa);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    Tarefa tarefa = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Tarefa'),
        centerTitle: false,
        actions: [
          FlatButton(
            child: Text(
              'SALVAR',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              submitForm(context, tarefa);
            },
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: TextFormField(
            initialValue: tarefa.texto,
            decoration: InputDecoration(
              labelText: "Descrição",
              border: OutlineInputBorder(),
            ),
            onSaved: (value) => _tarefa.texto = value,
            validator: (value) => value.isEmpty ? "Campo obrigatório" : null,
          ),
        ),
      ),
    );
  }
}
