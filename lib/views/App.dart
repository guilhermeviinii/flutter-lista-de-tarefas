import 'package:flutter/material.dart';
import 'package:tarefas/views/edita.page.dart';
import 'package:tarefas/views/lista.page.dart';
import 'package:tarefas/views/nova.page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp um unico só - Método para desenhar a tela do aplicativo
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => ListaPage(),
        '/nova': (context) => NovaPage(),
        '/edita': (context) => EditaPage(),
      },
      initialRoute: '/',
    );
  }
}
