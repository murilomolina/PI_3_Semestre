import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/data/trabalhos.dart';

class EditaTrabalhoPage extends StatelessWidget {
  final Trabalhos trabalho;

  const EditaTrabalhoPage({super.key, required this.trabalho});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _tituloController = TextEditingController(text: trabalho.titulo);
    final TextEditingController _orientadorController = TextEditingController(text: trabalho.orientador);
    final TextEditingController _coorientadorController = TextEditingController(text: trabalho.coorientador);
    final TextEditingController _resumoController = TextEditingController(text: trabalho.resumo);
    final TextEditingController _idEstandeController = TextEditingController(text: trabalho.idEstande);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Trabalho'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Text("Para manter o conteúdo basta não alterar nenhum dado!!", style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)),
            TextFormField(
              controller: _tituloController,
              decoration: const InputDecoration(labelText: 'Titulo'),
            ),
            TextFormField(
              controller: _orientadorController,
              decoration: const InputDecoration(labelText: 'Orientador (numero inteiro)'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            TextFormField(
              controller: _coorientadorController,
              decoration: const InputDecoration(labelText: 'Coorientador (numero inteiro)'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            TextFormField(
              controller: _resumoController,
              decoration: const InputDecoration(labelText: 'Resumo'),
            ),
            TextFormField(
              controller: _idEstandeController,
              decoration: const InputDecoration(labelText: 'Id Estande'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Chamada para editar o trabalho passando os valores dos controllers
                  await editaTrabalho(
                    int.parse(trabalho.idTrabalho),
                    _tituloController.text,
                    int.parse(_orientadorController.text),
                    int.parse(_coorientadorController.text) ,
                    _resumoController.text,
                    int.parse(_idEstandeController.text) ,
                  );
                  showDialog(
                    // ignore: use_build_context_synchronously
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        content: Text("Trabalho editado com sucesso!"),
                      );
                    },
                  );
                } catch (e) {
                  // Em caso de erro, exibe um dialogo de erro
                  showDialog(
                    // ignore: use_build_context_synchronously
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text("Erro ao tentar editar Trabalho page: $e"),
                      );
                    },
                  );
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
