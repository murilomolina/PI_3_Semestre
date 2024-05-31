import 'package:flutter/material.dart';
import 'package:myapp/data/aluno.dart';

class InsereAluno extends StatelessWidget {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();

  InsereAluno({super.key});
  
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inserir Aluno'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _cpfController,
              decoration: const InputDecoration(labelText: 'CPF'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  insereAluno(
                  _nomeController.text,
                  _emailController.text,
                  _cpfController.text,
                );
                showDialog(
                  // ignore: use_build_context_synchronously
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      content: Text("Usuario inserido com sucesso!"),
                    );
                  },
                );
                } catch (e) {
                  showDialog(
                  // ignore: use_build_context_synchronously
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text("Erro ao tentar inserir usuario $e"),
                    );
                  },
                );
                }
              },
              child: const Text('Inserir'),
            ),
          ],
        ),
      ),
    );
  }
}